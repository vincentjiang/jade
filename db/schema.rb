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

ActiveRecord::Schema.define(version: 20131212035259) do

  create_table "certificates", force: true do |t|
    t.string   "report_no"
    t.boolean  "is_hoklas"
    t.date     "date_test"
    t.date     "date_issue"
    t.string   "shape"
    t.string   "object"
    t.string   "cut"
    t.decimal  "dimensions1"
    t.decimal  "dimensions2"
    t.decimal  "dimensions3"
    t.decimal  "dimension"
    t.decimal  "weight"
    t.string   "weight_desc"
    t.string   "transparency"
    t.string   "deep1"
    t.string   "color1"
    t.string   "deep2"
    t.string   "color2"
    t.string   "deep3"
    t.string   "color3"
    t.string   "distribution"
    t.string   "polariscope"
    t.decimal  "refractive_index"
    t.boolean  "is_measure"
    t.decimal  "ww1"
    t.decimal  "ww2"
    t.decimal  "ww3"
    t.decimal  "sg"
    t.string   "uv_lw"
    t.string   "uv_sw"
    t.string   "chelsea_color_filter"
    t.string   "visible_spectrum"
    t.string   "magnification"
    t.string   "surface_feature"
    t.string   "infrared_spectrum"
    t.string   "level"
    t.string   "conclusion"
    t.text     "comments"
    t.string   "img_url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "ename"
    t.string   "cname"
    t.string   "etitle"
    t.string   "ctitle"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
