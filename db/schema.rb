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

ActiveRecord::Schema.define(version: 20151111064357) do

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

  create_table "events", force: true do |t|
    t.string   "esearch"
    t.string   "regulatory_focus"
    t.string   "appname"
    t.integer  "apporder"
    t.integer  "review"
    t.integer  "detail"
    t.integer  "purchase"
    t.string   "clickorder"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mockupapps", force: true do |t|
    t.string   "esearch"
    t.string   "regulatory_focus"
    t.integer  "apporder"
    t.string   "appname"
    t.text     "description"
    t.text     "icon"
    t.text     "screenshot1"
    t.text     "screenshot2"
    t.text     "screenshot3"
    t.float    "averagerating"
    t.integer  "totalrating"
    t.string   "distribution"
    t.integer  "num_star5"
    t.integer  "num_star4"
    t.integer  "num_star3"
    t.integer  "num_star2"
    t.integer  "num_star1"
    t.float    "pct_star5"
    t.float    "pct_star4"
    t.float    "pct_star3"
    t.float    "pct_star2"
    t.float    "pct_star1"
    t.string   "price"
    t.integer  "subjectinfo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mockupreviews", force: true do |t|
    t.string   "esearch"
    t.integer  "apporder"
    t.string   "appname"
    t.integer  "revieworder"
    t.integer  "star"
    t.text     "title"
    t.text     "author"
    t.text     "content"
    t.string   "date"
    t.integer  "mockupapp_id"
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

  create_table "subjectinfos", force: true do |t|
    t.string   "esearch"
    t.string   "regulatory_focus"
    t.integer  "mobile_user"
    t.integer  "appstore"
    t.integer  "visit_frequency"
    t.integer  "app_expense"
    t.integer  "previous_experience"
    t.string   "ip_address"
    t.datetime "start_time"
    t.string   "browser"
    t.string   "browser_version"
    t.string   "platform"
    t.string   "os"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: true do |t|
    t.string   "esearch"
    t.string   "regulatory_focus"
    t.string   "age"
    t.integer  "gender"
    t.integer  "income"
    t.integer  "involvement1"
    t.integer  "involvement2"
    t.integer  "involvement3"
    t.integer  "rf1"
    t.integer  "rf2"
    t.integer  "rf3"
    t.integer  "rf4"
    t.integer  "rf5"
    t.integer  "rf6"
    t.integer  "rf7"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
