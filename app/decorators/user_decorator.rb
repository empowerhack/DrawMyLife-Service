class UserDecorator < Draper::Decorator
  delegate_all
  include ActionView::Helpers::UrlHelper

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def email_link(mask_deleted: true)
    if mask_deleted && object.deleted_at.present?
      "<em>Deleted user</em>".html_safe
    else
      "<a href=\"mailto:#{object.email}\">#{object.email}</a>".html_safe
    end
  end

  def organisation_name
    object.organisation.name
  end

  def active_status
    unless object.active_for_authentication?
      unless object.confirmed?
        "New Account Awaiting Confirmation"
      else
        "Inactive"
      end
    else
      if devise_mapping.confirmable? && object.pending_reconfirmation?
        "Active - Waiting on confirmation for new email address: <strong>#{object.unconfirmed_email}</strong>".html_safe
      else
        "Active"
      end
    end
  end

  def active_status_toggle_link
    if object.active_for_authentication?
      action = "deactivate user"
      url = Rails.application.routes.url_helpers.user_deactivate_path(object)
      confirmation = "Are you sure you want to deactivate this user? Note: this will NOT remove the user's uploaded drawings."
      request_method = :put
      link_data = { confirm: confirmation }
    else
      if object.confirmed?
        action = "reactivate user"
        url = Rails.application.routes.url_helpers.user_reactivate_path(object)
        confirmation = "Are you sure you want to reactivate this user?"
        request_method = :put
        link_data = { confirm: confirmation }
      else
        action = "resend confirmation email"
        url = Rails.application.routes.url_helpers.new_user_confirmation_path(email: object.email)
        request_method = :get
        link_data = {}
      end
    end

      link_to "#{action.capitalize}?", url, method: request_method, data: link_data
  end

  private

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
