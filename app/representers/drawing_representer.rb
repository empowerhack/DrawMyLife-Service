class DrawingRepresenter < Roar::Decorator
  include Roar::JSON::HAL

  property :country
  property :age
  property :gender
  property :mood_rating
  property :description
  property :story
  property :created_at

  link :self do
    drawing_path(id: represented.id, format: :hal)
  end
end
