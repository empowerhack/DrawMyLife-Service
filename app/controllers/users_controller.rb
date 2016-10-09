class UsersController < ApplicationController

  def index
    @users = (User.active.page params[:page]).decorate

    respond_to do |format|
      format.html
      format.js
    end
  end

end
