class DrawingsController < ApplicationController

  def index
    @drawings = Drawing.all
  end

  def new
  end
end
