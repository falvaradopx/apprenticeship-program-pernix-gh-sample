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

ActiveRecord::Schema[8.0].define(version: 2025_02_06_143912) do
  create_table "matches", force: :cascade do |t|
    t.string "player1_name"
    t.string "player1_symbol"
    t.integer "player1_wins"
    t.string "player2_name"
    t.string "player2_symbol"
    t.integer "player2_wins"
    t.string "difficulty"
    t.integer "draws"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
