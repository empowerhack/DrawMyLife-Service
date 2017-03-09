class UsersController < ApplicationController
  before_action :authenticate_user!, :authorize_super_admin!, :set_devise_mapping
  before_action :set_user, only: [:show, :edit, :update, :destroy, :deactivate, :reactivate]

  def index
    @users = (User.desc.page params[:page]).decorate

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Success! An email has been sent to #{@user.email} to confirm and activate their account."
      redirect_to users_path
    else
      flash.now[:error] = "Sorry, a new account could not be created. Please review your submission and try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Success! The user details were updated."
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Sorry, your changes could not be saved. Please review your changes and try again."
      render :edit
    end
  end

  def destroy
    @user.destroy

    # TODO
    # Notify user by email

    flash[:success] = "The user account for #{@user.email} was deleted."
    redirect_to users_path
  end

  def deactivate
    @user.soft_delete

    # TODO
    # Notify user by email

    flash[:success] = "The user account for #{@user.email} was deactivated."
    redirect_to user_path(@user)
  end

  def reactivate
    @user.reactivate

    # TODO
    # Notify user by email

    flash[:success] = "The user account for #{@user.email} was reactivated."
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :role, :country, :organisation_id)
  end

  def set_user
    @user ||= User.find(params[:id] || params[:user_id]).decorate
  end

  def set_devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
