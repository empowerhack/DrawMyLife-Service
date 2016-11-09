namespace :backfill do

  task :mood_rating_field do |task|
    Drawing.all.each do |drawing|
    	drawing.mood_rating = (drawing.mood_rating.to_f / 2.0).ceil
    	drawing.save
    end
  end
  
end