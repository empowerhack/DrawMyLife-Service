def hxlstats_column_headers()
  return ["Emotional State",
          "Stage of journey",
          "Country drawn in",
          "Total children affected",
          "Children who identify as female",
          "Children who identify as male",
          "Children who identify as neither female nor male",
          "Children between the ages of 5-12",
          "Children between the ages of 13-18",
          "Children under 5 years old",
          "Older than 18 years old"]
end 

def hxlstats_tags()
  return ["#impact+indicator+code",
          "#affected+children",
          "#country+code",
          "#affected+children+total",
          "#affected+children+female",
          "#affected+children+male",
          "#affected+children+indicator",
          "#affected+children+age_5_12",
          "#affected+children+age_13_18",
          "#affected+children+age_under5",
          "#affected+children+age_18plus"]
end


class HxlStatsView < ActiveRecord::Base
  # View aggregates data in a multi-nested-group by for the HXL proxy/endpoint
  #
  self.table_name = 'hxl_stats_view'
  def readonly?
    true
  end



  def self.get_counts_by_gender(hxlstatsmajorgroup)
      # Group by gender and aggregate
      gender_totals = Hash.new(0)
      @hxlstatsgroupsgender = hxlstatsmajorgroup.group_by(&:gender) # shorthand for { |hxlstat| hxlstat.gender }
      @hxlstatsgroupsgender.each do |k_gender, v_gender|
        # puts "    cycle genders"
        # puts "    %s " % k_gender
        # puts "    %s " % v_gender
        gender_totals[k_gender] = v_gender.count
      end
      return gender_totals # hash of key gender to v counts
  end

  def self.get_counts_by_age(hxlstatsmajorgroup)
      # Processing Age aggregations
      @hxlstatsgroupsage = hxlstatsmajorgroup.group_by(&:age) # shorthand for { |hxlstat| hxlstat.age }
      younger_than_five = 0 # gender *and* age inclusiveness 
      five_twelve_total = 0
      thirteen_eighteen_total = 0
      older_total = 0
      @hxlstatsgroupsage.each do |k_age, _v_age|
        # k_age is age, _v_age is array of hxlstatsmatview
        # puts "    cycle ages"
        # puts "    %s" % k_age
        # puts "    %s" % _v_age.count
        if k_age < 5
          younger_than_five += 1
        elsif k_age >= 5 && k_age < 13
          five_twelve_total += 1
        elsif k_age >= 13 && k_age <= 18
          thirteen_eighteen_total += 1
        else
          older_total += 1
        end
      end
    return younger_than_five, five_twelve_total, thirteen_eighteen_total, older_total
  end

  def self.hxl_stats_counts()
    results = []
    @hxlstats = HxlStatsView.all

    # First group by major categories, before aggregating independently for gender and age and recombining
    @hxlstatsgroups = @hxlstats.group_by { |hxlstat| [hxlstat.mood_rating, hxlstat.stage_of_journey, hxlstat.country] }
    @hxlstatsgroups.each do |keys, hxlstatsmajorgroup| # keys = mood_rating, stage_of_j, country
      gender_totals = get_counts_by_gender(hxlstatsmajorgroup)
      younger_than_five, five_twelve_total, thirteen_eighteen_total, older_total = get_counts_by_age(hxlstatsmajorgroup)
      results.append([*keys,
                      hxlstatsmajorgroup.count,
                      gender_totals[0],
                      gender_totals[1],
                      gender_totals[2],
                      five_twelve_total,
                      thirteen_eighteen_total,
                      younger_than_five,
                      older_total])
    end
    return results
  end

  # rubocop:disable MethodLength
  def self.results_by_emotional_state() 
    @results = []
    @results = @results.append(hxlstats_column_headers())
    @results = @results.append(hxlstats_tags())
    @results = @results.push(*hxl_stats_counts())
    return @results
  end

end