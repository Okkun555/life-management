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

ActiveRecord::Schema[7.2].define(version: 2025_09_28_114814) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "ユーザーID"
    t.date "birthday", null: false, comment: "生年月日"
    t.integer "sex", default: 0, null: false, comment: "生物学的性別(0:秘密, 1:男性, 2:女性)"
    t.boolean "is_public", default: false, null: false, comment: "公開設定(0:非公開, 1:公開)"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
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

  add_foreign_key "profiles", "users"
end
