class CreateHxlStatsView < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW hxl_stats_view AS
      SELECT d.id AS drawing_id,
             d.*,
             u.country as user_country,
             o.id AS org_id,
             o.name AS org_name
      FROM drawings d,
                    users u,
                    organisations o
      WHERE d.user_id = u.id AND
            u.organisation_id = o.id
    SQL
  end

  def down
    execute <<-SQL
     DROP VIEW IF EXISTS hxl_stats_view
    SQL
  end
end
