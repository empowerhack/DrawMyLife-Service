require 'rails_helper'

RSpec.describe DrawingRepresenter do
  let(:drawing_resource) { FactoryGirl.create(:drawing, created_at: Time.now) }
  let(:representer) { JSON.parse(described_class.new(drawing_resource).to_json) }

  describe "representations" do
    subject { representer }

    it "includes the expected attributes" do
      expect(subject.keys).to contain_exactly(
        *%w(country age gender mood_rating description story created_at _links)
      )
    end
  end

  describe "links" do
    subject { representer["_links"] }

    context "self" do
      its(["self"]) { is_expected.to include("href" => "/drawings/#{drawing_resource.id}.hal") }
    end
  end
end
