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

ActiveRecord::Schema.define(version: 20160123040501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "directors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "directors", ["name"], name: "index_directors_on_name", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "members", ["name"], name: "index_members_on_name", using: :btree

  create_table "movie_directors", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "director_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "movie_directors", ["director_id"], name: "index_movie_directors_on_director_id", using: :btree
  add_index "movie_directors", ["movie_id"], name: "index_movie_directors_on_movie_id", using: :btree

  create_table "movie_members", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "movie_members", ["member_id"], name: "index_movie_members_on_member_id", using: :btree
  add_index "movie_members", ["movie_id"], name: "index_movie_members_on_movie_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "fk"
    t.float    "rating"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "movies", ["fk"], name: "index_movies_on_fk", using: :btree
  add_index "movies", ["rating"], name: "index_movies_on_rating", using: :btree
  add_index "movies", ["title"], name: "index_movies_on_title", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
