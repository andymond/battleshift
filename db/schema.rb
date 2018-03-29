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

ActiveRecord::Schema.define(version: 20180329005445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "colosseums", force: :cascade do |t|
    t.uuid "user_id"
    t.bigint "game_id"
    t.integer "gladiator_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_colosseums_on_game_id"
    t.index ["user_id"], name: "index_colosseums_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.text "player_1_board"
    t.text "player_2_board"
    t.integer "winner"
    t.integer "player_1_turns", default: 0
    t.integer "player_2_turns", default: 0
    t.integer "current_turn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.text "email"
    t.text "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  add_foreign_key "colosseums", "games"
  add_foreign_key "colosseums", "users"
end
