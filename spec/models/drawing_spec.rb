require 'rails_helper'

RSpec.describe Drawing, type: :model do
  describe "validations" do
    PRIORITY_FIELDS = %i(description subject_matter mood_rating country).freeze

    subject { FactoryGirl.build(:drawing, attrs) }

    let(:attrs) { FactoryGirl.attributes_for(:drawing, status: status) }
    let(:status) { "complete" }

    it { is_expected.to define_enum_for(:status).with(%i(pending complete)) }
    it { is_expected.to define_enum_for(:gender).with(%i(not_specified female male other)) }

    %i(image status).each do |attr|
      it { is_expected.to validate_presence_of attr }
    end

    it { is_expected.to validate_numericality_of(:age) }

    it do
      is_expected.to validate_numericality_of(:mood_rating)
        .is_greater_than_or_equal_to(1)
    end

    it do
      is_expected.to validate_numericality_of(:mood_rating)
        .is_less_than_or_equal_to(10)
    end

    context "images/paperclip" do
      it { is_expected.to validate_attachment_presence(:image) }

      it { is_expected.to have_attached_file(:image) }

      it do
        is_expected.to validate_attachment_content_type(:image)
          .allowing('image/png', 'image/gif', 'image/jpeg', 'image/tiff', 'image/bmp', 'application/pdf')
          .rejecting('application/zip', 'image/x-png')
      end
    end

    context "status is complete" do
      PRIORITY_FIELDS.each do |attr|
        it { is_expected.to validate_presence_of attr }
      end
    end

    context "status is pending" do
      let(:status) { "pending" }

      PRIORITY_FIELDS.each do |attr|
        it { is_expected.to_not validate_presence_of attr }
      end
    end
  end
end
