class DrawingDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def description_concat
    text_concat(object.description)
  end

  def story_concat
    text_concat(object.story)
  end

  private

  def text_concat(text, max_length = 30)
    text[0, max_length-1].concat('...')
  end
end
