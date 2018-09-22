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


ActiveRecord::Schema.define(version: 20180913011211) do


  create_table "captured_images", force: :cascade do |t|
    t.string  "content"
    t.integer "status"
    t.integer "prototype_id"
  end

  add_index "captured_images", ["prototype_id"], name: "index_captured_images_on_prototype_id"

  create_table "prototype_tags", force: :cascade do |t|
    t.integer  "prototype_id", null: false
    t.integer  "tag_id",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "prototype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "prototype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prototype_tags", force: :cascade do |t|
    t.integer  "prototype_id", null: false
    t.integer  "tag_id",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "prototypes", force: :cascade do |t|
    t.string   "title"
    t.string   "catch_copy"
    t.text     "concept"
    t.integer  "user_id"
    t.integer  "likes_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "prototypes", ["user_id"], name: "index_prototypes_on_user_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "name"
    t.text     "profile"
    t.string   "position"
    t.text     "occupation"
    t.string   "avatar"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
