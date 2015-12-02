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

ActiveRecord::Schema.define(version: 20151201174643) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "title",         limit: 255
    t.string   "cover",         limit: 255
    t.date     "start"
    t.date     "end"
    t.datetime "enroll"
    t.string   "address",       limit: 255
    t.string   "gather",        limit: 255
    t.integer  "limit",         limit: 4
    t.integer  "fee",           limit: 4
    t.text     "stay",          limit: 65535
    t.text     "insurance",     limit: 65535
    t.text     "tip",           limit: 65535
    t.text     "bak",           limit: 65535
    t.integer  "apply_count",   limit: 4,     default: 0
    t.integer  "view_count",    limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.text     "html_body",     limit: 65535
    t.text     "html_subtitle", limit: 65535
  end

  create_table "activity_intros", force: :cascade do |t|
    t.integer "activity_id", limit: 4
    t.string  "title",       limit: 255
    t.string  "instruction", limit: 255
    t.string  "image",       limit: 255, default: "--- []\n"
  end

  create_table "activity_shows", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "content",    limit: 255
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "applies", force: :cascade do |t|
    t.integer  "activity_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.string   "name",        limit: 255
    t.string   "mobile",      limit: 255
    t.string   "email",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "source",      limit: 255
    t.integer  "source_id",   limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "reply_id",    limit: 4
    t.string   "content",     limit: 255
    t.string   "image",       limit: 255
    t.integer  "likes_count", limit: 4,   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "follows", force: :cascade do |t|
    t.string   "source",     limit: 255
    t.integer  "link_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "runnings", force: :cascade do |t|
    t.integer  "phase",         limit: 4
    t.string   "name",          limit: 255
    t.integer  "follows_count", limit: 4,   default: 0
    t.string   "cover",         limit: 255
    t.string   "url",           limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "likes_count",   limit: 4,   default: 0
    t.integer  "views_count",   limit: 4,   default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "mobile",     limit: 255
    t.string   "password",   limit: 255
    t.string   "name",       limit: 255
    t.string   "gender",     limit: 255
    t.string   "salt",       limit: 255
    t.string   "source",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
