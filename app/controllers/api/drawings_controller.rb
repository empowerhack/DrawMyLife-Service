class API::DrawingsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :hal

  before_action :authenticate_user!

  def index
    drawings = Drawing.desc.page params[:page]
    respond_with drawings, represent_with: DrawingCollectionRepresenter
  end

  def show
    drawing = Drawing.find(params[:id]).decorate
    respond_with drawing, represent_with: DrawingRepresenter
  end
end
