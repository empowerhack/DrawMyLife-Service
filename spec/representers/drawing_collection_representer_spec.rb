require 'rails_helper'

RSpec.describe DrawingCollectionRepresenter do
  before do
    3.times { FactoryGirl.create(:drawing, created_at: Time.now) }
  end

  let(:page) { 1 }
  let(:paginated_drawings) { Drawing.desc.page page }
  let(:representer) { JSON.parse(described_class.new(paginated_drawings).to_json) }

  describe "representations" do
    subject { representer }

    it "includes the expected attributes" do
      expect(subject.keys).to contain_exactly(
        *%w(drawings total_entries _links)
      )
    end
  end

  describe "links" do
    subject { representer["_links"] }

    context "self" do
      its(["self"]) { is_expected.to include("href" => "/drawings.hal?page=#{page}") }
    end
  end
end