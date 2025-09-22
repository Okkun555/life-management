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

ActiveRecord::Schema[7.2].define(version: 2025_09_21_111939) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mission_statement_values", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "ユーザーID"
    t.text "content", null: false, comment: "内容"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mission_statement_values_on_user_id"
  end

  create_table "todo_list_items", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "ユーザーID"
    t.bigint "todo_list_id", null: false, comment: "TODOリストID"
    t.string "content", null: false, comment: "TODO内容"
    t.integer "status", default: 1, null: false, comment: "TODOステータス（1:未完了, 2:完了）"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todo_list_id"], name: "index_todo_list_items_on_todo_list_id"
    t.index ["user_id"], name: "index_todo_list_items_on_user_id"
  end

  create_table "todo_lists", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "ユーザーID"
    t.string "title", null: false, comment: "リストタイトル（通常は日付が入る）"
    t.boolean "is_current", default: false, null: false, comment: "当日有効なリストかどうか"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "title"], name: "index_todo_lists_on_user_id_and_title", unique: true
    t.index ["user_id"], name: "index_todo_lists_on_user_id"
  end

  create_table "todo_reviews", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "ユーザーID"
    t.bigint "todo_list_id", null: false, comment: "TODOリストID"
    t.text "review", comment: "振り返りコメント"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todo_list_id"], name: "index_todo_reviews_on_todo_list_id"
    t.index ["user_id"], name: "index_todo_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false, comment: "アカウント名"
    t.string "email", null: false, comment: "メールアドレス"
    t.string "supabase_uid", null: false, comment: "supabaseのuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["supabase_uid"], name: "index_users_on_supabase_uid", unique: true
  end

  add_foreign_key "mission_statement_values", "users"
  add_foreign_key "todo_list_items", "todo_lists"
  add_foreign_key "todo_list_items", "users"
  add_foreign_key "todo_lists", "users"
  add_foreign_key "todo_reviews", "todo_lists"
  add_foreign_key "todo_reviews", "users"
end
