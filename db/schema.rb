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

ActiveRecord::Schema.define(version: 2021_02_05_165526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_countries_on_code", unique: true
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "directions", force: :cascade do |t|
    t.bigint "director_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["director_id", "movie_id"], name: "index_directions_on_director_id_and_movie_id", unique: true
    t.index ["director_id"], name: "index_directions_on_director_id"
    t.index ["movie_id"], name: "index_directions_on_movie_id"
  end

  create_table "directors", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_directors_on_country_id"
    t.index ["name"], name: "index_directors_on_name"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id", "user_id"], name: "index_memberships_on_team_id_and_user_id", unique: true
    t.index ["team_id"], name: "index_memberships_on_team_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "original_title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["original_title"], name: "index_movies_on_original_title"
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.bigint "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_rounds_on_movie_id"
    t.index ["team_id"], name: "index_rounds_on_team_id"
    t.index ["user_id"], name: "index_rounds_on_user_id"
  end

  create_table "screenings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "round_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id", "user_id"], name: "index_screenings_on_round_id_and_user_id", unique: true
    t.index ["round_id"], name: "index_screenings_on_round_id"
    t.index ["user_id"], name: "index_screenings_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", limit: 40, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.date "birthdate"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.string "email_confirmation_token", default: "", null: false
    t.datetime "email_confirmed_at"
    t.index ["country_id"], name: "index_users_on_country_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "directions", "directors"
  add_foreign_key "directions", "movies"
  add_foreign_key "directors", "countries"
  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "rounds", "movies"
  add_foreign_key "rounds", "teams"
  add_foreign_key "rounds", "users"
  add_foreign_key "screenings", "rounds"
  add_foreign_key "screenings", "users"
  add_foreign_key "users", "countries"
end
