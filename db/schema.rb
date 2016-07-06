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

ActiveRecord::Schema.define(version: 20160706150414) do

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

  create_table "catalogs", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "name"
    t.string   "only_change"
    t.integer  "owner_id"
    t.integer  "classifier_id"
    t.integer  "commerce_information_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "catals", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "name"
    t.string   "changes"
    t.integer  "owner_id"
    t.integer  "classifier_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "classifiers", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "name"
    t.string   "only_change"
    t.integer  "owner_id"
    t.integer  "commerce_information_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "commerce_informations", force: :cascade do |t|
    t.string   "version"
    t.string   "date"
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

  create_table "groups_products", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "product_id"
  end

  create_table "handbooks", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "value"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "handbooks_products", id: false, force: :cascade do |t|
    t.integer "handbook_id"
    t.integer "product_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string   "schema_version"
    t.string   "data"
    t.string   "only_change"
    t.string   "id_xml"
    t.string   "name"
    t.integer  "classifier_id"
    t.integer  "catalog_id"
    t.integer  "owner_id"
    t.integer  "commerce_information_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
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

  create_table "price_type_tax_values", force: :cascade do |t|
    t.integer  "price_type_id"
    t.integer  "tax_id"
    t.string   "value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "price_types", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "name"
    t.string   "currency"
    t.integer  "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", force: :cascade do |t|
    t.string   "presentation"
    t.string   "price"
    t.string   "coefficient"
    t.string   "currency"
    t.string   "unit"
    t.integer  "proposal_id"
    t.integer  "price_type_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "product_attribute_values", force: :cascade do |t|
    t.integer  "product_attribute_id"
    t.integer  "product_id"
    t.string   "value"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "product_attributes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_attributes_products", id: false, force: :cascade do |t|
    t.integer "product_attribute_id"
    t.integer "product_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.string   "link_image"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_properties", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "property_id"
    t.string   "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "product_requisites", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "requisite_id"
    t.string   "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "product_tax_values", force: :cascade do |t|
    t.integer "product_id"
    t.integer "tax_id"
    t.string  "value"
  end

  create_table "products", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "barcode"
    t.string   "vendorcode"
    t.string   "name"
    t.string   "type_product"
    t.string   "type_nomenclature"
    t.integer  "catalog_id"
    t.integer  "unit_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
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

  create_table "proposals", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proposals_storages", force: :cascade do |t|
    t.string   "quantity"
    t.integer  "proposal_id"
    t.integer  "storage_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "requisites", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "storages", force: :cascade do |t|
    t.string   "id_xml"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "full_name"
    t.string   "intern_cut"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
