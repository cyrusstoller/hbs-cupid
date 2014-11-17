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

ActiveRecord::Schema.define(version: 20141115012919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "cached_percentage_results", force: true do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.float    "score1"
    t.float    "score2"
    t.float    "final_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cached_percentage_results", ["final_score"], name: "index_cached_percentage_results_on_final_score", using: :btree
  add_index "cached_percentage_results", ["user1_id"], name: "index_cached_percentage_results_on_user1_id", using: :btree
  add_index "cached_percentage_results", ["user2_id"], name: "index_cached_percentage_results_on_user2_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "text"
    t.text     "background"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submitted_answers", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "accepted_answer_ids", array: true
    t.integer  "intensity"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submitted_answers", ["accepted_answer_ids"], name: "index_submitted_answers_on_accepted_answer_ids", using: :gin
  add_index "submitted_answers", ["answer_id"], name: "index_submitted_answers_on_answer_id", using: :btree
  add_index "submitted_answers", ["question_id"], name: "index_submitted_answers_on_question_id", using: :btree
  add_index "submitted_answers", ["user_id"], name: "index_submitted_answers_on_user_id", using: :btree

  create_table "users", force: true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "active"
    t.boolean  "admin"
  end

  add_index "users", ["active"], name: "index_users_on_active", using: :btree
  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
