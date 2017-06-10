class HxlStatsView < ActiveRecord::Base
  self.table_name = 'hxl_stats_view'
  def readonly?
    true
  end

end
