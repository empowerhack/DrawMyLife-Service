class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize_super_admin!
    unless current_user.super_admin?
      flash[:error] = "Sorry, you may be a super human being, but you need to be a super admin to do that."
      redirect_to root_path
    end
  end
end
