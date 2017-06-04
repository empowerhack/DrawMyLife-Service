class HxlStatsView < ActiveRecord::Base
  self.table_name = 'hxl_stats_view'
  def readonly?
    true
  end

  def self.to_csv # Not actually used! But could be convenient for data analysts. was %w{ } but rubocop!
    attributes = %w(org_name country mood_rating drawing_id user_id org_id description
                    image_file_name mood_rating age subject_matter story country status
                    gender stage_of_journey origin_country user_country org_name)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |hxlstats|
        csv << attributes.map{ |attr| hxlstats.send(attr) }
      end
    end
  end

end
