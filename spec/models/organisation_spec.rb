require 'rails_helper'

RSpec.describe Organisation, type: :model do
  describe "validations" do
    context "presence" do
      it { is_expected.to validate_presence_of :name }
    end
  end
end
