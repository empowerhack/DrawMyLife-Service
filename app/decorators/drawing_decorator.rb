class DrawingDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def description_concat
    text_concat(object.description) unless object.description.nil?
  end

  def story_concat
    text_concat(object.story) unless object.story.nil?
  end

  private

  def text_concat(text, max_length=100)
    text.length > max_length ? text[0, max_length - 1].concat('...') : text
  end
end
