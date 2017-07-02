class API::DrawingsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :hal

  before_action :restrict_access!

  def index
    drawings = Drawing.desc.page params[:page]
    respond_with drawings, represent_with: DrawingCollectionRepresenter
  end

  def show
    drawing = Drawing.find(params[:id]).decorate
    respond_with drawing, represent_with: DrawingRepresenter
  end

  private

  def restrict_access!
    authenticate_or_request_with_http_token do |token, options|
      APIKey.exists?(access_token: token)
    end
  end
end
