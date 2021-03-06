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

ActiveRecord::Schema.define(version: 2019_06_20_012124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_players", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_players_on_group_id"
    t.index ["player_id"], name: "index_group_players_on_player_id"
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_players", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.integer "group_id"
    t.index ["group_id"], name: "index_groups_players_on_group_id"
    t.index ["player_id"], name: "index_groups_players_on_player_id"
  end

  create_table "players", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.integer "admin_id"
    t.index ["name", "admin_id"], name: "index_players_on_name_and_admin_id", unique: true
  end

  create_table "power_grid_maps", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "power_grids", force: :cascade do |t|
    t.integer "game_number"
    t.integer "player_id"
    t.integer "map_id"
    t.boolean "win"
    t.integer "score"
    t.integer "money"
    t.integer "admin_id"
    t.datetime "datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seven_wonder_boards", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "expansion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seven_wonders", id: :serial, force: :cascade do |t|
    t.integer "game_number"
    t.integer "player_id"
    t.integer "board_id"
    t.boolean "win"
    t.integer "score"
    t.datetime "datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_id"
  end

  add_foreign_key "group_players", "groups"
  add_foreign_key "group_players", "players"
  add_foreign_key "groups_players", "groups"
  add_foreign_key "groups_players", "players"
end
