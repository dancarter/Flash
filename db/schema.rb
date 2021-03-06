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

ActiveRecord::Schema.define(version: 20140126181140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: true do |t|
    t.text     "front",                                null: false
    t.text     "back",                                 null: false
    t.integer  "user_id",                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "easiness_factor",        default: 2.5
    t.integer  "number_repetitions",     default: 0
    t.integer  "quality_of_last_recall"
    t.date     "next_repetition"
    t.integer  "repetition_interval"
    t.date     "last_studied"
  end

  create_table "review_list_cards", force: true do |t|
    t.integer  "review_list_id", null: false
    t.integer  "card_id",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "review_list_tags", force: true do |t|
    t.integer  "review_list_id", null: false
    t.integer  "tag_id",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "review_lists", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount",                                  null: false
    t.integer  "user_id"
    t.integer  "review_list_cards_count", default: 0
    t.integer  "last_card"
    t.boolean  "srs_review",              default: false
    t.integer  "new_count"
    t.integer  "max"
    t.date     "due_after"
  end

  add_index "review_lists", ["review_list_cards_count"], name: "index_review_lists_on_review_list_cards_count", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "card_id",    null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["card_id", "tag_id"], name: "index_taggings_on_card_id_and_tag_id", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",                           null: false
    t.integer  "user_id",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taggings_count", default: 0
    t.boolean  "share",          default: false
    t.integer  "share_count",    default: 0,     null: false
  end

  add_index "tags", ["taggings_count"], name: "index_tags_on_taggings_count", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
