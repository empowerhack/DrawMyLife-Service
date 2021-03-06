module DrawingsHelper
  def preview_image(drawing)
    if drawing.image.exists?
      drawing.image.url(:medium)
    else
      'placeholder.png'
    end
  end

  def form_title
    @drawing.new_record? ? "Add Drawing" : "Edit Drawing"
  end

  def radio_statuses
    get_humanized_options(Drawing.statuses.keys)
  end

  def radio_genders
    get_humanized_options(Drawing.genders.keys)
  end

  def mood_select_box
    # Example output: [ ["1 (sad face)", 1], ["2", 2] ... ["4", 4] ["5 (happy face)", 5] ]
    selections = (1..5).map do |number|
      [number.to_s, number]
    end

    selections[0][0] += " 😢"
    selections[-1][0] += " 😃"
    selections
  end

  def image_consent_default
    @drawing.new_record? ? true : @drawing.image_consent
  end

  def get_humanized_options(options)
    # Example output: [ ["Gender 0", "gender0"], ["Gender 1", "gender1"] ... ]
    options.map do |option|
      [option.humanize, option]
    end
  end
end
