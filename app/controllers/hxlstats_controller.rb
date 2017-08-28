class HxlstatsController < ApplicationController
  def show
    @results = HxlStatsView.results_by_emotional_state

    respond_to do |format|
      format.html
      format.json { send_data @results.to_json, filename: "hxlstats-#{Date.today}.json" }
    end
  end
end
