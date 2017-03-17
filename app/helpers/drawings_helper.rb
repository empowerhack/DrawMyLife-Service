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
    # Example output: [ ["status1", "status1"], ["status2", "status2"] ]
    [].tap do |arr|
      Drawing.statuses.keys.each { |s| arr << [s, s] }
    end
  end

  def radio_genders
    # Example output: [ ["gender0", "Gender 0"], ["gender1", "Gender 1"] ... ]
    [].tap do |arr|
      Drawing.genders.keys.each { |s| arr << [s.humanize, s] }
    end
  end

  def mood_select_box
    # Example output: [ ["1 (sad face)", 1], ["2", 2] ... ["4", 4] ["5 (happy face)", 5] ]
    selections = [].tap do |arr|
      (1..5).each { |n| arr << [n.to_s, n] }
    end
    selections[0][0] += " 😢"
    selections[-1][0] += " 😃"
    selections
  end

  def journey_options
    selections = ["At home", "In temporary shelter", "Awaiting transit", "On the move", "Arrived at destination"]
  end

  def image_consent_default
    @drawing.new_record? ? true : @drawing.image_consent
  end
end
