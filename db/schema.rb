# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_24_112553) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.string "board_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id", null: false
    t.index ["game_id"], name: "index_boards_on_game_id"
  end

  create_table "boats", force: :cascade do |t|
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "n_of_cells"
    t.bigint "board_id", null: false
    t.bigint "player_room_id", null: false
    t.index ["board_id"], name: "index_boats_on_board_id"
    t.index ["player_room_id"], name: "index_boats_on_player_room_id"
  end

  create_table "coordinates", force: :cascade do |t|
    t.string "state"
    t.integer "x"
    t.integer "y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "board_id", null: false
    t.bigint "boat_id", null: false
    t.index ["board_id"], name: "index_coordinates_on_board_id"
    t.index ["boat_id"], name: "index_coordinates_on_boat_id"
  end

  create_table "friend_requests", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "player_id", null: false
    t.bigint "friend_id", null: false
    t.index ["friend_id"], name: "index_friend_requests_on_friend_id"
    t.index ["player_id"], name: "index_friend_requests_on_player_id"
  end

  create_table "friends", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "player_id", null: false
    t.index ["player_id"], name: "index_friends_on_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_id", null: false
    t.integer "current_player_number"
    t.integer "winner"
    t.index ["room_id"], name: "index_games_on_room_id"
  end

  create_table "player_rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "player_id", null: false
    t.bigint "room_id", null: false
    t.string "status"
    t.integer "player_number"
    t.boolean "bonification"
    t.string "state"
    t.index ["player_id"], name: "index_player_rooms_on_player_id"
    t.index ["room_id"], name: "index_player_rooms_on_room_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "auth_key"
    t.integer "n_win_games"
    t.integer "n_lose_games"
    t.integer "n_played_games"
    t.integer "n_bonifications"
    t.integer "n_effectiveness"
    t.integer "turns_mean_of_games"
    t.integer "mean_of_misses_by_game"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
  end

  create_table "turns", force: :cascade do |t|
    t.integer "x_cord"
    t.integer "y_cord"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id", null: false
    t.bigint "player_id", null: false
    t.boolean "bonification"
    t.string "result"
    t.index ["game_id"], name: "index_turns_on_game_id"
    t.index ["player_id"], name: "index_turns_on_player_id"
  end

  add_foreign_key "boards", "games"
  add_foreign_key "boats", "boards"
  add_foreign_key "boats", "player_rooms"
  add_foreign_key "coordinates", "boards"
  add_foreign_key "coordinates", "boats"
  add_foreign_key "friend_requests", "friends"
  add_foreign_key "friend_requests", "players"
  add_foreign_key "friends", "players"
  add_foreign_key "games", "rooms"
  add_foreign_key "player_rooms", "players"
  add_foreign_key "player_rooms", "rooms"
  add_foreign_key "turns", "games"
  add_foreign_key "turns", "players"
end
