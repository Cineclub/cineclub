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

ActiveRecord::Schema.define(version: 2021_03_17_171114) do

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
    t.string "name", null: false
    t.bigint "tmdb_id", null: false
    t.string "imdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imdb_id"], name: "index_directors_on_imdb_id", unique: true
    t.index ["name"], name: "index_directors_on_name"
    t.index ["tmdb_id"], name: "index_directors_on_tmdb_id", unique: true
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "invitee_id", null: false
    t.bigint "inviter_id", null: false
    t.bigint "team_id", null: false
    t.datetime "dismissed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dismissed_at"], name: "index_invitations_on_dismissed_at"
    t.index ["invitee_id", "dismissed_at"], name: "index_invitations_on_invitee_id_and_dismissed_at"
    t.index ["invitee_id", "team_id", "dismissed_at"], name: "index_invitations_on_invitee_id_and_team_id_and_dismissed_at"
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
    t.index ["inviter_id"], name: "index_invitations_on_inviter_id"
    t.index ["team_id"], name: "index_invitations_on_team_id"
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
    t.integer "year", null: false
    t.bigint "tmdb_id", null: false
    t.string "imdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imdb_id"], name: "index_movies_on_imdb_id", unique: true
    t.index ["original_title"], name: "index_movies_on_original_title"
    t.index ["tmdb_id"], name: "index_movies_on_tmdb_id", unique: true
    t.index ["year"], name: "index_movies_on_year"
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.bigint "movie_id"
    t.integer "index_in_team", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_rounds_on_movie_id"
    t.index ["team_id", "index_in_team"], name: "index_rounds_on_team_id_and_index_in_team", unique: true
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
    t.boolean "admin", default: false, null: false
    t.index ["admin"], name: "index_users_on_admin"
    t.index ["country_id"], name: "index_users_on_country_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["email_confirmation_token"], name: "index_users_on_email_confirmation_token"
    t.index ["email_confirmed_at"], name: "index_users_on_email_confirmed_at"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "directions", "directors"
  add_foreign_key "directions", "movies"
  add_foreign_key "invitations", "teams"
  add_foreign_key "invitations", "users", column: "invitee_id"
  add_foreign_key "invitations", "users", column: "inviter_id"
  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "rounds", "movies"
  add_foreign_key "rounds", "teams"
  add_foreign_key "rounds", "users"
  add_foreign_key "screenings", "rounds"
  add_foreign_key "screenings", "users"
  add_foreign_key "users", "countries"
end
