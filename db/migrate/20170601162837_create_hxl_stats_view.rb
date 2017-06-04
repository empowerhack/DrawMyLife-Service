class CreateHxlStatsView < ActiveRecord::Migration
  def up 
    execute <<-SQL
      CREATE VIEW hxl_stats_view AS
      SELECT d.id AS drawing_id, 
             d.*,
             -- u.id AS user_id,  -- available from drawings
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

=begin
# Schema - for convenience
 create_table "drawings", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
    t.integer  "mood_rating"
    t.integer  "age"
    t.string   "subject_matter"
    t.text     "story"
    t.string   "country"
    t.integer  "status",             default: 0
    t.integer  "gender",             default: 0
    t.string   "stage_of_journey"
    t.boolean  "image_consent",      default: false, null: false
    t.string   "origin_country"
  end

  add_index "drawings", ["user_id"], name: "index_drawings_on_user_id", using: :btree

  create_table "organisations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "organisation_id"
    t.string   "country"
    t.datetime "deleted_at"
    t.integer  "role",                   default: 0
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
=end
