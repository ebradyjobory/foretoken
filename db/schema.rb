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

ActiveRecord::Schema.define(version: 20141014142940) do

  create_table "forecast_apis", force: true do |t|
    t.integer  "forecast_api_year"
    t.integer  "forecast_api_value"
    t.integer  "project_api_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.string   "indicator"
    t.integer  "start_date"
    t.integer  "end_date"
  end

  add_index "forecast_apis", ["project_api_id"], name: "index_forecast_apis_on_project_api_id", using: :btree

  create_table "forecasts", force: true do |t|
    t.integer  "year"
    t.integer  "value"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mean"
    t.integer  "mean_id"
    t.integer  "b1"
    t.integer  "b0"
    t.integer  "time"
    t.integer  "tbar"
    t.integer  "ttbar"
    t.integer  "xxbar_ttbar"
    t.integer  "ttbar_sq"
  end

  add_index "forecasts", ["mean_id"], name: "index_forecasts_on_mean_id", using: :btree
  add_index "forecasts", ["project_id"], name: "index_forecasts_on_project_id", using: :btree

  create_table "future_apis", force: true do |t|
    t.integer  "future_api_year"
    t.integer  "project_api_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "future_apis", ["project_api_id"], name: "index_future_apis_on_project_api_id", using: :btree

  create_table "futures", force: true do |t|
    t.integer  "future_year"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mean"
    t.integer  "forecasted"
  end

  add_index "futures", ["project_id"], name: "index_futures_on_project_id", using: :btree

  create_table "means", force: true do |t|
    t.integer  "mean"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forecast_id"
  end

  create_table "project_apis", force: true do |t|
    t.string   "project_api_name", limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "project_apis", ["user_id"], name: "index_project_apis_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name",        limit: 50
    t.integer  "forecast_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_confirmation"
    t.integer  "project_api_id"
  end

end
