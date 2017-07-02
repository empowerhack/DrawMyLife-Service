class DrawingMinimalRepresenter < BaseRepresenter
  property :dml_id
  property :description

  nested :artist do
    property :age
  end

  link :self do
    drawing_url(id: represented, format: :hal)
  end

  link :thumbnail do
    represented.image.url(:thumb)
  end
end
