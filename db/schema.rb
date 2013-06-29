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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130619131935) do

  create_table "businesses", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "name"
    t.string   "url"
    t.string   "phone"
    t.string   "state"
    t.string   "zip_code"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "category"
    t.boolean  "gmaps"
    t.string   "mon_from"
    t.string   "mon_to"
    t.string   "tue_from"
    t.string   "tue_to"
    t.string   "wed_from"
    t.string   "wed_to"
    t.string   "thur_from"
    t.string   "thur_to"
    t.string   "fri_from"
    t.string   "fri_to"
    t.string   "sat_from"
    t.string   "sat_to"
    t.string   "sun_from"
    t.string   "sun_to"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
