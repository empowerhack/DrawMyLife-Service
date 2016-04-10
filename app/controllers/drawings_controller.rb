class DrawingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_drawing, only: [:show, :edit, :update, :destroy]
  before_action :owned_drawing, only: [:edit, :update, :destroy]

  def index
    @drawings = Drawing.desc.page params[:page]
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @drawings }
    end
  end

  def new
    @drawing = current_user.drawings.build
  end

  def create
    @drawing = current_user.drawings.build(drawing_params)
    if @drawing.save
      flash[:success] = "Your drawing is uploaded."
      redirect_to drawings_path
    else
      flash.now[:error] = "Oh no! Something went wrong."
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @drawing }
    end
  end

  def edit
  end

  def update
    if @drawing.update(drawing_params)
      flash[:success] = "Your drawing was updated."
      redirect_to(drawing_path(@drawing))
    else
      flash[:error] = "Something went wrong."
      render :edit
    end
  end

  def destroy
    @drawing.destroy
    redirect_to drawings_path
  end

  private

  def owned_drawing
    return unless current_user != @drawing.user
    flash[:alert] = "That's not your drawing."
    redirect_to root_path
  end

  def drawing_params
    params.require(:drawing).permit(:image, :name, :description, :location_id, :gender, :age, :mood_rating, :subject_matter, :story)
  end

  def set_drawing
    @drawing = Drawing.find(params[:id])
  end
end
