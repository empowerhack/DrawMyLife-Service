module DrawingsHelper
  def preview_image(drawing)
    if drawing.image.exists?
      drawing.image.url(:medium)
    else
      'placeholder.png'
    end
  end

  def drawings_class
    index_view = current_page?(root_path) || current_page?(controller: "drawings", action: "index")
    index_view ? "col-xs-6 col-sm-4" : "drawings-full"
  end

  def radio_statuses
    # Example output: [ ["status1", "status1"], ["status2", "status2"] ]
    [].tap do |arr|
      Drawing.statuses.keys.each { |s| arr << [s, s] }
    end
  end

  def mood_select_box
    # Example output: [ ["1 😢", 1], ["2", 2] ... ["9", 9] ["10 😃", 10] ]
    selections = [].tap do |arr|
      (1..10).each { |n| arr << ["#{n}", n] }
    end
    selections[0][0] += " 😢"
    selections[-1][0] += " 😃"
    selections
  end
end
