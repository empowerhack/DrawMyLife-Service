require 'rails_helper'

RSpec.describe Drawing, type: :model do
  describe "validations" do
    context "presence" do
      %i(image age gender subject_matter mood_rating).each do |attr|
        it { is_expected.to validate_presence_of attr }
      end
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
  end
end
