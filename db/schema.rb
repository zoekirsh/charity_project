# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 7) do

  create_table "activities", force: :cascade do |t|
    t.string "activity_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "income_sum"
  end

  create_table "charities", force: :cascade do |t|
    t.integer "ein"
    t.string "name"
    t.string "category"
    t.string "state"
    t.integer "management_fees"
    t.boolean "accepting_donations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "legal_fees"
    t.integer "income_amount"
  end

  create_table "charity_activities", force: :cascade do |t|
    t.integer "charity_id"
    t.integer "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
