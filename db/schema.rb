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

ActiveRecord::Schema.define(version: 20160704152945) do

  create_table "banks", force: :cascade do |t|
    t.integer  "payment_account_id"
    t.boolean  "corespondent_bank"
    t.string   "name"
    t.string   "correspondent_account"
    t.string   "bik"
    t.string   "address"
    t.string   "post_index"
    t.string   "country"
    t.string   "region"
    t.string   "area"
    t.string   "city"
    t.string   "street"
    t.string   "build"
    t.string   "housing"
    t.string   "flat"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "classifiers", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "name"
    t.integer  "classifier_id"
    t.integer  "groupable_id"
    t.string   "groupable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "handbooks", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "value"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ml_catalogs", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "name"
    t.string   "changes"
    t.integer  "owner_id"
    t.integer  "classifier_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "name"
    t.string   "official_name"
    t.string   "name_type"
    t.string   "comment"
    t.string   "address"
    t.string   "post_index"
    t.string   "country"
    t.string   "region"
    t.string   "area"
    t.string   "city"
    t.string   "street"
    t.string   "build"
    t.string   "housing"
    t.string   "flat"
    t.string   "inn"
    t.string   "kpp"
    t.string   "okpo"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "payment_accounts", force: :cascade do |t|
    t.string   "payment_account"
    t.integer  "owner_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "properties", force: :cascade do |t|
    t.integer  "classifier_id"
    t.string   "id_xml"
    t.string   "name"
    t.string   "value"
    t.string   "for_product"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
