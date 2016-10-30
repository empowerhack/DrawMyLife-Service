require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject { FactoryGirl.build(:user) }

      %i(email country).each do |attr|
        it { is_expected.to validate_presence_of attr }
      end

      it 'validates length of email' do
        should validate_length_of(:email)
        .is_at_least(4)
        .is_at_most(60)
      end
  end

  describe "#active_for_authentication?" do
    context "active user" do
      it "returns true" do
        expect(subject.active_for_authentication?).to be true
      end
    end
    context "deleted user" do
      it "returns false" do
        subject.soft_delete
        expect(subject.active_for_authentication?).to be false
      end
    end
  end

  describe "#inactive message?" do
    context "active user" do
      it "returns inactive" do
        expect(subject.inactive_message).to eq :inactive
      end
    end
    context "deleted user" do
      it "returns deleted account" do
        subject.soft_delete
        expect(subject.inactive_message).to eq :deleted_account
      end
    end
  end

  describe "#soft_delete" do
    before do
      Timecop.freeze(Time.local(2016))
    end
    context "deleting a user" do
      it 'records deletion time' do
        subject.soft_delete
        expect(subject.deleted_at).to eq(Time.local(2016))
      end
    end
  end
end
