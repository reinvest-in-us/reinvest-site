# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_19_192613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "elected_officials", force: :cascade do |t|
    t.string "name", null: false
    t.string "position", null: false
    t.string "reelection_date"
    t.integer "list_rank", null: false
    t.bigint "police_district_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["police_district_id"], name: "index_elected_officials_on_police_district_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "event_datetime"
    t.string "phone_number"
    t.bigint "police_district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agenda_link"
    t.index ["police_district_id"], name: "index_meetings_on_police_district_id"
  end

  create_table "police_districts", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.integer "fy_2019_policing_budget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "decision_makers"
    t.text "how_to_comment"
    t.string "timezone"
    t.bigint "total_city_budget"
    t.integer "general_fund_percent"
    t.index ["slug"], name: "index_police_districts_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "meetings", "police_districts"
end
