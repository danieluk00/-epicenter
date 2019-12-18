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

ActiveRecord::Schema.define(version: 2019_12_18_153501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "event_name"
    t.string "venue_type"
    t.datetime "start_dt"
    t.string "event_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "registration_deadline"
    t.string "venue_name"
    t.string "venue_address"
    t.string "venue_phone"
    t.string "venue_photo_url"
    t.float "venue_rating"
    t.string "venue_url"
    t.string "venue_map_link"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "phone_number"
    t.boolean "organiser"
    t.string "address"
    t.string "token"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.boolean "included_in_epicenter"
    t.index ["event_id"], name: "index_users_on_event_id"
  end

  add_foreign_key "users", "events"
end
