module DrawingsHelper
  def preview_image(drawing)
    if drawing.image.exists?
      drawing.image.url(:medium)
    else
      'placeholder.png'
    end
  end
end
