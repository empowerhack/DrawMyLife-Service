class DrawingCollectionRepresenter < Roar::Decorator
  include Roar::JSON::HAL
  include Roar::Contrib::Decorator::PageRepresenter

  collection :drawings, exec_context: :decorator, decorator: DrawingRepresenter

  def drawings
    represented
  end

  def page_url(args)
    drawings_path(format: :hal, page: args[:page])
  end
end