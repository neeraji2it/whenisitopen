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

ActiveRecord::Schema.define(:version => 20130902122044) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "username"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "businesses", :force => true do |t|
    t.string  "address"
    t.string  "city"
    t.string  "company_name"
    t.string  "contact_name"
    t.string  "employee"
    t.string  "fax_number"
    t.string  "gender"
    t.text    "major_division_description"
    t.string  "phone"
    t.string  "state"
    t.string  "sales"
    t.text    "sic_2_code_description"
    t.string  "sic_4_code"
    t.string  "category"
    t.string  "title"
    t.string  "url"
    t.string  "mon_from"
    t.string  "mon_to"
    t.string  "tue_from"
    t.string  "tue_to"
    t.string  "wed_from"
    t.string  "wed_to"
    t.string  "thu_from"
    t.string  "thu_to"
    t.string  "fri_from"
    t.string  "fri_to"
    t.string  "sat_from"
    t.string  "sat_to"
    t.string  "sun_from"
    t.string  "sun_to"
    t.string  "zip_code"
    t.float   "longitude"
    t.float   "latitude"
    t.boolean "gmaps"
    t.string  "mon_closed"
    t.string  "tue_closed"
    t.string  "wed_closed"
    t.string  "thu_closed"
    t.string  "fri_closed"
    t.string  "sat_closed"
    t.string  "sun_closed"
    t.string  "status"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pending_scrappers", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "company_name"
    t.string   "contact_name"
    t.string   "employee"
    t.string   "fax_number"
    t.string   "gender"
    t.text     "major_division_description"
    t.string   "phone"
    t.string   "state"
    t.string   "sales"
    t.text     "sic_2_code_description"
    t.string   "sic_4_code"
    t.string   "category"
    t.string   "title"
    t.string   "url"
    t.string   "mon_from"
    t.string   "mon_to"
    t.string   "tue_from"
    t.string   "tue_to"
    t.string   "wed_from"
    t.string   "wed_to"
    t.string   "thu_from"
    t.string   "thu_to"
    t.string   "fri_from"
    t.string   "fri_to"
    t.string   "sat_from"
    t.string   "sat_to"
    t.string   "sun_from"
    t.string   "sun_to"
    t.string   "zip_code"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "mon_closed"
    t.string   "tue_closed"
    t.string   "wed_closed"
    t.string   "thu_closed"
    t.string   "fri_closed"
    t.string   "sat_closed"
    t.string   "sun_closed"
    t.boolean  "gmaps"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

end
