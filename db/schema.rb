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

ActiveRecord::Schema[7.1].define(version: 2024_12_16_090525) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_mines", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.integer "x"
    t.integer "y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id", "x", "y"], name: "index_board_mines_on_board_id_and_x_and_y", unique: true
    t.index ["board_id"], name: "index_board_mines_on_board_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_boards_on_email"
    t.index ["name"], name: "index_boards_on_name"
  end

  add_foreign_key "board_mines", "boards"
end
