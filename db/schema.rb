# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_09_17_065548) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "sleeps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.bigint "duration_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_time"], name: "index_sleeps_on_end_time"
    t.index ["start_time"], name: "index_sleeps_on_start_time"
    t.index ["user_id", "start_time"], name: "index_sleeps_on_user_id_and_start_time"
    t.index ["user_id"], name: "index_sleeps_on_user_id"
    t.index ["user_id"], name: "index_sleeps_on_user_id_open_sleep", unique: true, where: "(end_time IS NULL)"
  end

  create_table "user_follows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "idx_user_follows_on_followed_id"
    t.index ["user_id", "followed_id"], name: "idx_user_follows_on_user_id_and_followed_id", unique: true
    t.index ["user_id"], name: "idx_user_follows_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "sleeps", "users"
end
