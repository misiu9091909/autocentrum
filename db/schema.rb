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

ActiveRecord::Schema.define(version: 20150115210449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "be_combines", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.integer  "start_year"
    t.integer  "end_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "engine_id"
    t.integer  "body_id"
    t.json     "techspec"
  end

  add_index "be_combines", ["body_id"], name: "index_be_combines_on_body_id", using: :btree
  add_index "be_combines", ["engine_id"], name: "index_be_combines_on_engine_id", using: :btree

  create_table "bodies", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.string   "body_type"
    t.integer  "start_year"
    t.integer  "end_year"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "generation_id"
    t.json     "techspec"
  end

  add_index "bodies", ["generation_id"], name: "index_bodies_on_generation_id", using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consumptions", force: :cascade do |t|
    t.string   "fuel_type"
    t.float    "min"
    t.float    "max"
    t.float    "min_long"
    t.float    "average"
    t.float    "official"
    t.integer  "count"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "consumable_id"
    t.string   "consumable_type"
  end

  add_index "consumptions", ["consumable_type", "consumable_id"], name: "index_consumptions_on_consumable_type_and_consumable_id", using: :btree

  create_table "engines", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.string   "engine_type"
    t.integer  "start_year"
    t.integer  "end_year"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "generation_id"
  end

  add_index "engines", ["generation_id"], name: "index_engines_on_generation_id", using: :btree

  create_table "generations", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.integer  "start_year"
    t.integer  "end_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "kind_id"
  end

  add_index "generations", ["kind_id"], name: "index_generations_on_kind_id", using: :btree

  create_table "kinds", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.string   "segment"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "brand_id"
    t.integer  "original_parts"
    t.integer  "replacement_parts"
  end

  add_index "kinds", ["brand_id"], name: "index_kinds_on_brand_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "ratings_count"
    t.integer  "again_count"
    t.integer  "again"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.json     "rates"
  end

  add_index "ratings", ["rateable_type", "rateable_id"], name: "index_ratings_on_rateable_type_and_rateable_id", using: :btree

  add_foreign_key "be_combines", "bodies"
  add_foreign_key "be_combines", "engines"
  add_foreign_key "bodies", "generations"
  add_foreign_key "engines", "generations"
  add_foreign_key "generations", "kinds"
  add_foreign_key "kinds", "brands"
end
