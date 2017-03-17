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

ActiveRecord::Schema.define(version: 20170317040901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "dip_id"
    t.index ["dip_id"], name: "index_activities_on_dip_id", using: :btree
  end

  create_table "activities_locations", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "location_id", null: false
    t.index ["activity_id"], name: "index_activities_locations_on_activity_id", using: :btree
    t.index ["location_id"], name: "index_activities_locations_on_location_id", using: :btree
  end

  create_table "dips", force: :cascade do |t|
    t.string   "mood_for"
    t.integer  "distance"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "place"
    t.integer  "activity_id"
    t.integer  "location_type_id"
    t.index ["activity_id"], name: "index_dips_on_activity_id", using: :btree
    t.index ["location_type_id"], name: "index_dips_on_location_type_id", using: :btree
  end

  create_table "location_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_types_locations", force: :cascade do |t|
    t.integer "location_type_id", null: false
    t.integer "location_id",      null: false
    t.index ["location_id"], name: "index_location_types_locations_on_location_id", using: :btree
    t.index ["location_type_id"], name: "index_location_types_locations_on_location_type_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "address"
    t.integer  "activity_id"
    t.integer  "location_type_id"
    t.string   "URL"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "description"
    t.integer  "review_id"
    t.boolean  "saved",            default: false
    t.boolean  "checkin",          default: false
    t.datetime "checkin_time"
    t.index ["activity_id"], name: "index_locations_on_activity_id", using: :btree
    t.index ["location_type_id"], name: "index_locations_on_location_type_id", using: :btree
    t.index ["review_id"], name: "index_locations_on_review_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "comments"
    t.index ["location_id"], name: "index_reviews_on_location_id", using: :btree
  end

  create_table "selections", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "location_id"
    t.integer  "activity_id"
    t.integer  "location_type_id"
    t.integer  "dip_id"
    t.index ["activity_id"], name: "index_selections_on_activity_id", using: :btree
    t.index ["dip_id"], name: "index_selections_on_dip_id", using: :btree
    t.index ["location_id"], name: "index_selections_on_location_id", using: :btree
    t.index ["location_type_id"], name: "index_selections_on_location_type_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "activities", "dips"
  add_foreign_key "activities_locations", "activities"
  add_foreign_key "activities_locations", "locations"
  add_foreign_key "dips", "activities"
  add_foreign_key "dips", "location_types"
  add_foreign_key "location_types_locations", "location_types"
  add_foreign_key "location_types_locations", "locations"
  add_foreign_key "locations", "activities"
  add_foreign_key "locations", "location_types"
  add_foreign_key "locations", "reviews"
  add_foreign_key "reviews", "locations"
  add_foreign_key "selections", "activities"
  add_foreign_key "selections", "dips"
  add_foreign_key "selections", "location_types"
  add_foreign_key "selections", "locations"
end
