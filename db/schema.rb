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

ActiveRecord::Schema[8.1].define(version: 2026_09_25_090000) do
  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.string "category", null: false
    t.string "location", null: false
    t.string "unit", null: false
    t.decimal "quantity", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "par_level", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "unit_cost_cents", default: 0, null: false
    t.integer "supplier_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shelf_life_days"
    t.index ["name"], name: "index_items_on_name", unique: true
    t.index ["supplier_id"], name: "index_items_on_supplier_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "reference", null: false
    t.integer "supplier_id", null: false
    t.string "status", default: "draft", null: false
    t.date "expected_on"
    t.integer "line_count", default: 0, null: false
    t.integer "total_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference"], name: "index_orders_on_reference", unique: true
    t.index ["supplier_id"], name: "index_orders_on_supplier_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name", null: false
    t.string "contact_name"
    t.string "email"
    t.string "phone"
    t.string "delivery_days"
    t.integer "lead_time_days", default: 1, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "role", default: "cook", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "items", "suppliers"
  add_foreign_key "orders", "suppliers"
  add_foreign_key "sessions", "users"
end
