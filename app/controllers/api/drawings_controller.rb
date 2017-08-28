class API::DrawingsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :hal

  before_action :restrict_access!

  def index
    drawings = Drawing.complete_with_consent.desc.page params[:page]
    respond_with drawings, represent_with: DrawingCollectionRepresenter
  end

  def show
    if (drawing = Drawing.find(params[:id])) && drawing.complete? && drawing.image_consent
      respond_with drawing.decorate, represent_with: DrawingRepresenter
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  private

  def restrict_access!
    authenticate_or_request_with_http_token do |token, _|
      APIKey.exists?(access_token: token)
    end
  end
end
