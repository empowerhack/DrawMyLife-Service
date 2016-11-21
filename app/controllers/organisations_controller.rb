class OrganisationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_organisation, only: [:edit, :show, :update, :destroy]

  def index
    @organisations = Organisation.all.order("name ASC")
  end

  def show
  end

  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new(organisation_params)
    if @organisation.save
      flash[:success] = "Your organisation was created."
      redirect_to organisations_path
    else
      flash.now[:error] = "Sorry, your organisation could not be saved. Please review your changes and try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @organisation.update(organisation_params)
      flash[:success] = "Your organisation was updated."
      redirect_to organisations_path
    else
      flash.now[:error] = "Sorry, your organisation could not be saved. Please review your changes and try again."
      render :edit
    end
  end

  def destroy
    @organisation.destroy
    redirect_to organisations_path
  end

  private

  def organisation_params
    params.require(:organisation).permit(:name)
  end

  def find_organisation
    @organisation = Organisation.find(params[:id])
  end
end
