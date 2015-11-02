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

ActiveRecord::Schema.define(version: 20151102071515) do

  create_table "applists", force: true do |t|
    t.text     "link"
    t.string   "appname"
    t.text     "icon"
    t.string   "store"
    t.string   "price"
    t.text     "description"
    t.string   "country"
    t.float    "average_current"
    t.integer  "total_current"
    t.float    "average_all"
    t.integer  "total_all"
    t.integer  "current1"
    t.integer  "current2"
    t.integer  "current3"
    t.integer  "current4"
    t.integer  "current5"
    t.integer  "all1"
    t.integer  "all2"
    t.integer  "all3"
    t.integer  "all4"
    t.integer  "all5"
    t.string   "compatibility"
    t.string   "category"
    t.string   "updated_date"
    t.string   "size"
    t.string   "seller"
    t.string   "rated"
    t.string   "requirements"
    t.string   "bundleid"
    t.text     "screenshot1"
    t.text     "screenshot2"
    t.text     "screenshot3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviewlists", force: true do |t|
    t.string   "appname"
    t.integer  "star"
    t.text     "title"
    t.text     "author"
    t.text     "content"
    t.string   "date"
    t.string   "country"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
