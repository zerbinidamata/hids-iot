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

ActiveRecord::Schema.define(version: 2021_04_11_203408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "actions_rules", id: false, force: :cascade do |t|
    t.bigint "rule_id", null: false
    t.bigint "action_id", null: false
    t.index ["action_id"], name: "index_actions_rules_on_action_id"
    t.index ["rule_id"], name: "index_actions_rules_on_rule_id"
  end

  create_table "actions_scripts", id: false, force: :cascade do |t|
    t.bigint "action_id", null: false
    t.bigint "script_id", null: false
    t.index ["action_id"], name: "index_actions_scripts_on_action_id"
    t.index ["script_id"], name: "index_actions_scripts_on_script_id"
  end

  create_table "rules", force: :cascade do |t|
    t.string "name"
    t.string "periodicity"
    t.boolean "shared"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rules_test_cases", id: false, force: :cascade do |t|
    t.bigint "rule_id", null: false
    t.bigint "test_case_id", null: false
    t.index ["rule_id"], name: "index_rules_test_cases_on_rule_id"
    t.index ["test_case_id"], name: "index_rules_test_cases_on_test_case_id"
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
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
