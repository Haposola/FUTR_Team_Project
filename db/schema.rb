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

ActiveRecord::Schema.define(:version => 20141029114047) do

  create_table "outservices", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "restaurant_comments", :force => true do |t|
    t.string   "nickname"
    t.string   "restaurant_name"
    t.text     "comment"
    t.integer  "star"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.string   "picture_addr"
    t.text     "description"
    t.integer  "star"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "signed_in_logs", :force => true do |t|
    t.string   "email"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "pwd_key"
    t.string   "nickname"
    t.string   "name"
    t.string   "nation"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
