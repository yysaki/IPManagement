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

ActiveRecord::Schema.define(version: 20130828054530) do

  create_table "available_ip_addresses", force: true do |t|
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ip_addr_usages", force: true do |t|
    t.string   "ip_address"
    t.string   "user"
    t.string   "machine_name"
    t.string   "location"
    t.string   "note"
    t.integer  "failed_ping_history"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "available_ip_address_id"
  end

  add_index "ip_addr_usages", ["ip_address"], name: "index_ip_addr_usages_on_ip_address", unique: true

end
