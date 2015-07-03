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

ActiveRecord::Schema.define(version: 20150703043257) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "devices_devices", force: true do |t|
    t.macaddr  "mac_address"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.boolean  "enabled",     default: true
  end

  add_index "devices_devices", ["mac_address"], name: "index_devices_devices_on_mac_address", using: :btree
  add_index "devices_devices", ["member_id"], name: "index_devices_devices_on_member_id", using: :btree
  add_index "devices_devices", ["type_id"], name: "index_devices_devices_on_type_id", using: :btree

  create_table "devices_types", force: true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hotspot"
  end

  create_table "members", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "active"
    t.integer  "nexudus_user_id"
    t.datetime "nexudus_updated_at"
    t.datetime "nexudus_created_at"
    t.uuid     "nexudus_unique_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "membership_status"
    t.datetime "membership_renewal_date"
    t.integer  "nexudus_id"
    t.integer  "membership_level_id"
  end

  add_index "members", ["email"], name: "index_members_on_email", using: :btree
  add_index "members", ["membership_level_id"], name: "index_members_on_membership_level_id", using: :btree
  add_index "members", ["nexudus_unique_id"], name: "index_members_on_nexudus_unique_id", using: :btree
  add_index "members", ["nexudus_updated_at"], name: "index_members_on_nexudus_updated_at", using: :btree

  create_table "membership_levels", force: true do |t|
    t.string   "name"
    t.string   "price"
    t.datetime "nexudus_updated_at"
    t.datetime "nexudus_created_at"
    t.integer  "nexudus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "network"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
