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

ActiveRecord::Schema.define(version: 2019_04_25_221500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "con_staffs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "badge"
    t.string "name"
    t.string "title"
    t.string "location"
  end

  create_table "events", force: :cascade do |t|
    t.string "event_code"
    t.string "event_year"
    t.string "event_location"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["event_code"], name: "index_events_on_event_code", unique: true
  end

  create_table "game_logs", force: :cascade do |t|
    t.string "title"
    t.datetime "timestamp"
    t.integer "badge"
    t.integer "rating"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.string "title"
    t.string "company"
    t.integer "quantity_total", default: 0
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["title"], name: "index_inventories_on_title", unique: true
  end

  create_table "libraries", force: :cascade do |t|
    t.string "title"
    t.integer "event"
    t.integer "badge"
    t.datetime "checked_out"
    t.datetime "checked_in"
    t.integer "quantity_left"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "participants", force: :cascade do |t|
    t.integer "badge"
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "pref"
    t.boolean "proxy"
    t.integer "p_badge"
    t.string "p_name"
    t.string "p_phone"
    t.string "p_email"
    t.string "p_pref"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["badge"], name: "index_participants_on_badge", unique: true
  end

  create_table "paw_staffs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "badge"
    t.string "name"
    t.string "title"
    t.string "phone"
    t.string "email"
    t.string "role"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "event"
    t.string "title"
    t.datetime "start"
    t.datetime "end"
    t.string "assigned"
    t.string "location"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

end
