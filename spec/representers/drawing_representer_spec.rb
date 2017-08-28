require 'rails_helper'

RSpec.describe DrawingRepresenter do
  DATE_FRACTIONAL_SECONDS = 3

  let(:url_host) { "http://localhost:3000/api" }
  let(:now) { Time.now }
  let(:drawing_resource) { FactoryGirl.create(:drawing, created_at: now) }
  let(:representer) { JSON.parse(described_class.new(drawing_resource).to_json) }

  describe "representations" do
    subject { representer }

    its(:keys) { is_expected.to include('_embedded', '_links') }

    it "includes the expected attributes" do
      expect(subject).to include(
        'dml_id' => drawing_resource.dml_id,
        'description' => drawing_resource.description,
        'country_code_drawn' => drawing_resource.country_code_drawn,
        'mood_rating' => drawing_resource.mood_rating,
        'subject_matter' => drawing_resource.subject_matter,
        'created_at' => drawing_resource.created_at.iso8601(DATE_FRACTIONAL_SECONDS),
        'updated_at' => drawing_resource.updated_at.iso8601(DATE_FRACTIONAL_SECONDS),

        'artist' => hash_including(
          'age' => drawing_resource.age,
          'gender' => drawing_resource.gender,
          'country_code_home' => drawing_resource.country_code_home,
          'stage_of_journey' => drawing_resource.stage_of_journey,
          'background_story' => drawing_resource.background_story
        )
      )
    end
  end

  describe "embedded" do
    subject { representer["_embedded"] }

    its(:keys) { is_expected.to include('organisation') }

    its(['organisation']) do
      is_expected.to include(
        'dml_id' => drawing_resource.organisation.dml_id,
        'name' => drawing_resource.user.organisation.name
      )
    end
  end

  describe "links" do
    subject { representer["_links"] }

    its(:keys) { is_expected.to include('self', 'image_large') }

    its(["self"]) { is_expected.to include("href" => "#{url_host}/drawings/#{drawing_resource.dml_id}") }
    its(["image_large"]) { is_expected.to include("href" => drawing_resource.image.url) }
  end
end
