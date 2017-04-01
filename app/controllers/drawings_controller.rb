class DrawingsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :hal

  before_action :authenticate_user!
  before_action :set_drawing, only: [:show, :edit, :update, :destroy]
  before_action :authorize_read, only: :show
  before_action :authorize_write, only: [:edit, :update, :destroy]

  def index
    query = current_user.super_admin? ? Drawing.desc : Drawing.within_org(current_user.organisation).desc
    drawings = query.page params[:page]
    @drawings = drawings.decorate

    respond_to do |format|
      format.html
      format.js
      format.hal { respond_with drawings, represent_with: DrawingCollectionRepresenter }
      format.csv { render text: drawings.to_csv(hxl: params[:hxl].present?) }
    end
  end

  def new
    @drawing = current_user.drawings.build.decorate
  end

  def create
    @drawing = current_user.drawings.build({"image": drawing_params["image"]}).decorate
    if @drawing.save
      flash[:success] = "Your drawing is uploaded."
      redirect_to drawings_path
    else
      flash.now[:error] = "Sorry, your drawing could not be saved. Please review your changes and try again."
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.hal { respond_with @drawing, represent_with: DrawingRepresenter }
    end
  end

  def edit
  end

  def update
    if @drawing.update(drawing_params)
      flash[:success] = "Your drawing was updated."
      redirect_to(drawing_path(@drawing))
    else
      flash.now[:error] = "Sorry, your drawing could not be saved. Please review your changes and try again."
      render :edit
    end
  end

  def destroy
    @drawing.destroy
    redirect_to drawings_path
  end

  private

  def authorize_read
    return if @drawing.can_view?(current_user)
    flash[:alert] = "You do not have permission to view this drawing."
    redirect_to root_path
  end

  def authorize_write
    return if @drawing.can_modify?(current_user)
    flash[:alert] = "You do not have permission to edit or delete this drawing."
    redirect_to root_path
  end

  def drawing_params
    params.require(:drawing).permit(:image, :description, :gender, :age, :mood_rating, :subject_matter,
                                    :story, :stage_of_journey, :country, :status, :image_consent, :origin_country)
  end

  def set_drawing
    @drawing ||= Drawing.find(params[:id]).decorate
  end
end
