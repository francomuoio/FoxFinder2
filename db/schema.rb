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

ActiveRecord::Schema.define(version: 2018_07_04_125739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.string "attachinariable_type"
    t.bigint "attachinariable_id"
    t.string "scope"
    t.string "public_id"
    t.string "version"
    t.integer "width"
    t.integer "height"
    t.string "format"
    t.string "resource_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent"
    t.index ["attachinariable_type", "attachinariable_id"], name: "index_attachinary_files_attachinariable"
  end

  create_table "companies", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "company_name"
    t.string "manager_first_name"
    t.string "manager_last_name"
    t.string "address"
    t.string "siret"
    t.string "pro_card_nbr"
    t.string "phone"
    t.string "company_type"
    t.boolean "siege"
    t.boolean "premium"
    t.string "website"
    t.text "description"
    t.string "photo"
    t.string "cover"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "negociators_id"
    t.bigint "properties_id"
    t.integer "role", default: 1
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["negociators_id"], name: "index_companies_on_negociators_id"
    t.index ["properties_id"], name: "index_companies_on_properties_id"
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "negociators", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.boolean "visibility"
    t.bigint "companies_id"
    t.index ["companies_id"], name: "index_negociators_on_companies_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "property_type"
    t.string "property_nbr"
    t.date "property_date"
    t.string "mandat_type"
    t.date "mandat_date"
    t.date "compromis_date"
    t.string "address"
    t.integer "price"
    t.boolean "fake"
    t.bigint "negociators_id"
    t.bigint "companies_id"
    t.index ["companies_id"], name: "index_properties_on_companies_id"
    t.index ["negociators_id"], name: "index_properties_on_negociators_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address"
    t.string "property_type"
    t.integer "room_nbr"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "companies", "negociators", column: "negociators_id"
  add_foreign_key "companies", "properties", column: "properties_id"
  add_foreign_key "negociators", "companies", column: "companies_id"
  add_foreign_key "properties", "companies", column: "companies_id"
  add_foreign_key "properties", "negociators", column: "negociators_id"
end
