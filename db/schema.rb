# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160524063953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cache_observed_properties", force: :cascade do |t|
    t.string   "property"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cache_offerings", force: :cascade do |t|
    t.string   "offering"
    t.string   "procedure"
    t.string   "beginTime"
    t.string   "endTime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
  end

  create_table "cache_swcb_rains", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cache_swcbs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cache_tweds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "observations", force: :cascade do |t|
    t.string   "phenomenonTime"
    t.string   "result"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "cache_offering_id"
  end

  create_table "offering_prorperty_ships", force: :cascade do |t|
    t.integer  "cache_offering_id"
    t.integer  "cache_observed_property_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
