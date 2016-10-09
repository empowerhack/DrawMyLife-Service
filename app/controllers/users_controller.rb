class UsersController < ApplicationController
  before_filter :authorize_user

  def index
    @users = (User.active.page params[:page]).decorate

    respond_to do |format|
      format.html
      format.js
    end
  end

  def authorize_user
    flash[:error] = "Sorry, you don't have access to that content."
    redirect_to root_path unless current_user.super_admin?
  end
end
