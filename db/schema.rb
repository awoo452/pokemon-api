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

ActiveRecord::Schema[8.1].define(version: 2026_02_26_000000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "pokemon", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "external_id"
    t.integer "height"
    t.string "name"
    t.jsonb "types"
    t.datetime "updated_at", null: false
    t.integer "weight"
  end

  create_table "request_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "duration_ms"
    t.string "http_method", null: false
    t.string "ip"
    t.jsonb "metadata"
    t.string "origin"
    t.jsonb "params"
    t.string "path", null: false
    t.string "referer"
    t.string "request_id"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.index ["created_at"], name: "index_request_logs_on_created_at"
    t.index ["ip"], name: "index_request_logs_on_ip"
    t.index ["path"], name: "index_request_logs_on_path"
    t.index ["request_id"], name: "index_request_logs_on_request_id"
  end
end
