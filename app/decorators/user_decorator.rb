class UserDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def email_link
    if object.deleted_at.present?
      "<em>Deleted user</em>".html_safe
    else
      "<a href=\"mailto:#{object.email}\">#{object.email}</a>".html_safe
    end
  end

  def organisation_name
    object.organisation.name
  end
end
