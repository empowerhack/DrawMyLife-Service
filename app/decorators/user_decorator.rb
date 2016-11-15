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
    object.organisation ? object.organisation.name : "N/A"
  end

  def organisation_link
    if object.organisation
      url = url_helper_class.organisation_path(object.organisation)
      link_to organisation_name, url
    else
      organisation_name
    end
  end

  def active_status
    if object.active_for_authentication?
      if awaiting_reconfirmation?
        "Active - Waiting on confirmation for new email address: <strong>#{object.unconfirmed_email}</strong>".html_safe
      else
        "Active"
      end
    else
      object.confirmed? ? "Inactive" : "New Account Awaiting Confirmation"
    end
  end

  def active_status_toggle_link
    if object.active_for_authentication?
      user_deactivation_link
    else
      object.confirmed? ? user_reactivation_link : user_resend_confirmation_link
    end
  end

  def user_deactivation_link
    url = url_helper_class.user_deactivate_path(object)
    confirmation = "Are you sure you want to deactivate this user? Note: this will NOT remove the user's uploaded drawings."
    link_to "Deactivate User?", url, method: :put, data: { confirm: confirmation }
  end

  def user_reactivation_link
    url = url_helper_class.user_reactivate_path(object)
    confirmation = "Are you sure you want to reactivate this user?"
    link_to "Reactivate User?", url, method: :put, data: { confirm: confirmation }
  end

  def user_resend_confirmation_link
    url = url_helper_class.new_user_confirmation_path(email: object.email)
    link_to "Resend Confirmation Email?", url
  end

  private

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def awaiting_reconfirmation?
    devise_mapping.confirmable? && object.pending_reconfirmation?
  end

  def url_helper_class
    Rails.application.routes.url_helpers
  end
end
