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

ActiveRecord::Schema.define(version: 20161119005822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "dips_id"
    t.index ["dips_id"], name: "index_activities_on_dips_id", using: :btree
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

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "address"
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

  add_foreign_key "activities", "dips", column: "dips_id"
  add_foreign_key "dips", "activities"
  add_foreign_key "dips", "location_types"
  add_foreign_key "selections", "activities"
  add_foreign_key "selections", "dips"
  add_foreign_key "selections", "location_types"
  add_foreign_key "selections", "locations"
end
