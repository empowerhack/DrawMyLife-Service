class DrawingCollectionRepresenter < Roar::Decorator
  include Roar::JSON::HAL
  include Roar::Contrib::Decorator::PageRepresenter

  collection :drawings, exec_context: :decorator, decorator: DrawingMinimalRepresenter

  property :total_entries, exec_context: :decorator
  property :current_page, exec_context: :decorator
  property :per_page, exec_context: :decorator

  def drawings
    represented
  end

  def page_url(args)
    drawings_path(format: :hal, page: args[:page])
  end
end
