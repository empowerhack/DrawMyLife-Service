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
        .is_less_than_or_equal_to(5)
    end

    it { should_not allow_value(nil).for(:image_consent) }

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

  shared_examples_for "a method that asserts a super admin or user in same org" do
    let(:instance) { FactoryGirl.create(:drawing) }
    let(:user) { FactoryGirl.create(:user) }

    context "user is super_admin" do
      before do
        user.role = "super_admin"
      end

      it { is_expected.to be true }
    end

    context "user is not super admin" do
      context "user has matching organisation id" do
        before do
          user.role = "admin"
          user.organisation_id = instance.user.organisation_id
        end

        it { is_expected.to be true }
      end

      context "user does not have matching organisation id" do
        before do
          user.role = "admin"
          user.organisation_id = instance.user.organisation_id + 1
        end

        it { is_expected.to be false }
      end
    end
  end

  describe "#can_view?" do
    subject { instance.can_view?(user) }

    it_behaves_like "a method that asserts a super admin or user in same org"
  end

  describe "#can_modify?" do
    subject { instance.can_modify?(user) }

    it_behaves_like "a method that asserts a super admin or user in same org"
  end
end
