class HxlstatsController < ApplicationController
  # Class to collect and aggregate data to parse to the HXL proxy/endpoint
  def new
  end

  def create
  end

  def show 
    # Prepare output results array
    @results = []
    @results.append(["Emotional State", "Stage of journey", "Country drawn in", "Total children affected", "Children who identify as female", "Children who identify as male", "Children who identify as neither female nor male", "Children between the ages of 5-12", "Children between the ages of 13-18", "Children under 5 years old ", "Older than 18 years old"])

    @hxlstats = HxlStatsView.all

    # Group by major categories, before aggregating subbuckets for gender and age
    @hxlstatsgroups = @hxlstats.group_by { |hxlstat| [hxlstat.mood_rating, hxlstat.stage_of_journey, hxlstat.country] }
    @hxlstatsgroups.each do |keys, hxlstatsgroup| 
      # keys = mood_rating, stage_of_j, country

      # Group by gender and aggregate
      gender_totals = Hash.new(0)
      @hxlstatsgroupsgender = hxlstatsgroup.group_by(&:gender) # shorthand for { |hxlstat| hxlstat.gender }
      @hxlstatsgroupsgender.each do |k_gender, v_gender|
        #puts "    cycle genders"
        #puts "    %s " % k_gender
        #puts "    %s " % v_gender
        gender_totals[k_gender] = v_gender.count
      end

      # puts "Processing Age aggregations"
      @hxlstatsgroupsage = hxlstatsgroup.group_by(&:age) # shorthand for { |hxlstat| hxlstat.age }
      younger_than_five = 0 # doesn't seem right to be gender neutral but age discriminatory
      five_twelve_total = 0
      thirteen_eighteen_total = 0
      older_total = 0
      @hxlstatsgroupsage.each do |k_age, v_age| 
        # k_age is age, v_age is array of hxlstatsmatview
        # puts "    cycle ages" 
        # puts "    %s" % k_age
        # puts "    %s" % v_age.count
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
       
      @results.append([*keys, hxlstatsgroup.count, gender_totals[0], gender_totals[1], gender_totals[2], 
                       five_twelve_total, thirteen_eighteen_total, younger_than_five, older_total])
    end
 
    respond_to do |format|
      format.html
      format.json { send_data @results, filename: "hxlstats-#{Date.today}.json" }
    end
  end

  def index
  end
end
