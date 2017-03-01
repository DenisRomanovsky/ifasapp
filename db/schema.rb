# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170228105841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "articles", force: :cascade do |t|
    t.integer  "mechanism_category_id"
    t.text     "article_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["mechanism_category_id"], name: "index_articles_on_mechanism_category_id", using: :btree

  create_table "auction_subcategories", id: false, force: :cascade do |t|
    t.integer "auction_id"
    t.integer "mechanism_subcategory_id"
  end

  add_index "auction_subcategories", ["auction_id", "mechanism_subcategory_id"], name: "auction_subcats_idx", using: :btree

  create_table "auctions", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mechanism_category_id"
    t.integer  "status"
    t.boolean  "delivery_included"
    t.boolean  "cash_payed"
    t.boolean  "with_tax"
    t.string   "user_email"
  end

  add_index "auctions", ["status"], name: "index_auctions_on_status", using: :btree
  add_index "auctions", ["user_id"], name: "index_auctions_on_user_id", using: :btree

  create_table "bids", force: :cascade do |t|
    t.float    "price"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "auction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",       default: 0
    t.integer  "mechanism_id"
  end

  add_index "bids", ["auction_id"], name: "index_bids_on_auction_id", using: :btree
  add_index "bids", ["status"], name: "index_bids_on_status", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "mechanism_categories", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "home_description"
    t.string   "slug"
  end

  create_table "mechanism_subcategories", force: :cascade do |t|
    t.text     "description"
    t.integer  "mechanism_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mechanisms", force: :cascade do |t|
    t.integer  "mechanism_category_id"
    t.integer  "mechanism_subcategory_id"
    t.string   "description"
    t.text     "long_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "mechanisms", ["mechanism_category_id", "mechanism_subcategory_id"], name: "by_category_subcategory", using: :btree
  add_index "mechanisms", ["user_id"], name: "index_mechanisms_on_user_id", using: :btree

  create_table "user_infos", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.integer  "city_id"
    t.integer  "user_status_cd"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unp"
    t.boolean  "send_email",     default: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_info_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_info_id"], name: "index_users_on_user_info_id", using: :btree

end
