class UserDecorator < Draper::Decorator
  delegate_all

  def email
    if object.deleted_at.present?
      "<em>Deleted user</em>".html_safe
    else
      "<a href=\"mailto:#{object.email}\">#{object.email}</a>".html_safe
    end
  end
end
