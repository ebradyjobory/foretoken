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

ActiveRecord::Schema.define(version: 20140912020112) do

  create_table "forecasts", force: true do |t|
    t.integer  "year"
    t.integer  "value"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forecasts", ["project_id"], name: "index_forecasts_on_project_id", using: :btree

  create_table "futures", force: true do |t|
    t.integer  "future_year"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "futures", ["project_id"], name: "index_futures_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name",        limit: 50
    t.integer  "forecast_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_confirmation"
  end

end
