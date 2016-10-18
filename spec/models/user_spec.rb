require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    USER_FIELDS = %i(email country).freeze
    subject { FactoryGirl.build(:user) }

    USER_FIELDS.each do |attr|
      it { is_expected.to validate_presence_of attr }
    end

    it { is_expected.to validate_length_of :email }
  end

  context "active user" do
    it "#active_for_authentication?" do
      expect(subject.active_for_authentication?).to be true
    end

    it "#inactive message?" do
      expect(subject.inactive_message).to eq :inactive
    end

    it "#soft_delete" do
      @current_time = Time.now
      allow(Time).to receive(:current).and_return(@current_time)
      subject.soft_delete
      expect(subject.deleted_at).to eq(@current_time)
    end
  end

  context "deleted user" do
    it "#active_for_authentication?" do
      subject.soft_delete
      expect(subject.active_for_authentication?).to be false
    end

    it "#inactive_message" do
      subject.soft_delete
      expect(subject.inactive_message).to eq :deleted_account
    end
  end
end
