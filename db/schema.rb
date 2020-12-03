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

ActiveRecord::Schema.define(version: 3) do

  create_table "categories", force: :cascade do |t|
    t.integer "charity_category_id"
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charities", force: :cascade do |t|
    t.integer "charity_category_id"
    t.string "name"
    t.integer "ein"
    t.string "state"
    t.integer "gross_fundraising"
    t.integer "management_fees"
    t.boolean "accepting_donations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charity_categories", force: :cascade do |t|
    t.integer "charity_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
