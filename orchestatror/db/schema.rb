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

ActiveRecord::Schema.define(version: 2021_05_08_233301) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "action_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "actions_scripts", id: false, force: :cascade do |t|
    t.bigint "action_id", null: false
    t.bigint "script_id", null: false
    t.index ["action_id"], name: "index_actions_scripts_on_action_id"
    t.index ["script_id"], name: "index_actions_scripts_on_script_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "device_groups", force: :cascade do |t|
    t.string "group_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "device_groups_rules", id: false, force: :cascade do |t|
    t.bigint "device_group_id", null: false
    t.bigint "rule_id", null: false
    t.index ["device_group_id"], name: "index_device_groups_rules_on_device_group_id"
    t.index ["rule_id"], name: "index_device_groups_rules_on_rule_id"
  end

  create_table "device_groups_scripts", id: false, force: :cascade do |t|
    t.bigint "device_group_id", null: false
    t.bigint "script_id", null: false
    t.index ["device_group_id"], name: "index_device_groups_scripts_on_device_group_id"
    t.index ["script_id"], name: "index_device_groups_scripts_on_script_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "device_group_id"
    t.index ["device_group_id"], name: "index_devices_on_device_group_id"
  end

  create_table "rules", force: :cascade do |t|
    t.string "name"
    t.string "periodicity"
    t.boolean "shared"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "action_id"
    t.bigint "test_case_id"
    t.index ["action_id"], name: "index_rules_on_action_id"
    t.index ["test_case_id"], name: "index_rules_on_test_case_id"
  end

  create_table "scripts", force: :cascade do |t|
    t.string "name"
    t.string "uri"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "scripts_test_cases", id: false, force: :cascade do |t|
    t.bigint "test_case_id", null: false
    t.bigint "script_id", null: false
    t.index ["script_id"], name: "index_scripts_test_cases_on_script_id"
    t.index ["test_case_id"], name: "index_scripts_test_cases_on_test_case_id"
  end

  create_table "test_cases", force: :cascade do |t|
    t.string "test_case_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
