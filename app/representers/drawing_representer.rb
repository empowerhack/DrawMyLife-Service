class DrawingRepresenter < BaseRepresenter
  property :dml_id
  property :description
  property :country_code_drawn
  property :mood_rating
  property :subject_matter
  property :created_at
  property :updated_at

  nested :artist do
    property :age
    property :gender
    property :country_code_home
    property :stage_of_journey
    property :background_story
  end

  link :self do
    api_drawing_url(format: :hal, id: represented)
  end

  link :image_large do
    represented.image.url
  end

  property :organisation, embedded: true do
    include Roar::JSON::HAL
    include ::Representer::Routing

    property :dml_id
    property :name
  end
end
