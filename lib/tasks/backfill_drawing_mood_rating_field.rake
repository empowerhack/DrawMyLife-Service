namespace :backfill do
  desc "Halves mood rating of any images uploaded before 24 Oct 16"
  task mood_rating_field: :environment do
    Drawing.all.each do |drawing|
      # If drawing has a mood rating and was last updated before we moved to a 1-5 scale
      if drawing.mood_rating? && drawing.updated_at <= Time.parse('24 Oct 2016')
        old_rating = drawing.mood_rating
        drawing.mood_rating = (drawing.mood_rating.to_f / 2.0).ceil
        drawing.save
        puts "Drawing number #{drawing.id} was updated from #{old_rating} to #{drawing.mood_rating}."
      else
        puts "Drawing number #{drawing.id} was not updated."
      end
    end
  end
end
