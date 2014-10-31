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

ActiveRecord::Schema.define(:version => 20141030064951) do

  create_table "act_tags", :force => true do |t|
    t.string   "name"
    t.string   "picname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "activities", :force => true do |t|
    t.string   "owner"
    t.string   "name"
    t.time     "tim"
    t.string   "tag"
    t.integer  "peoNum"
    t.string   "contact"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "com_for_acts", :force => true do |t|
    t.integer  "activity_id"
    t.string   "speaker"
    t.string   "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "outservice_comments", :force => true do |t|
    t.string   "service_kind"
    t.string   "nickname"
    t.string   "name"
    t.text     "comment"
    t.integer  "star"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "outservice_places", :force => true do |t|
    t.string   "service_kind"
    t.string   "name"
    t.string   "picture_addr"
    t.text     "description"
    t.integer  "star"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "outservices", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "q_about_acts", :force => true do |t|
    t.integer  "activity_id"
    t.string   "qustioner"
    t.string   "qustion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "re_for_ques_for_acts", :force => true do |t|
    t.integer  "q_about_act_id"
    t.string   "replier"
    t.string   "answer"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
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
