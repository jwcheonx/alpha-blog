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

ActiveRecord::Schema[7.1].define(version: 2024_09_20_083636) do
  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "author_id", null: false
    t.datetime "published_at"
    t.datetime "discarded_at"
    t.index ["author_id"], name: "fx_articles_author_id"
    t.index ["discarded_at"], name: "ix_articles_discarded_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "articles_count", default: 0, null: false
    t.index ["name"], name: "ux_categories_name", unique: true
  end

  create_table "categorizations", force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id", "category_id"], name: "ux_categorizations_article_id_category_id", unique: true
    t.index ["category_id", "article_id"], name: "ux_categorizations_category_id_article_id", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.integer "article_id", null: false
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "fx_comments_article_id"
    t.index ["author_id"], name: "fx_comments_author_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false, collation: "NOCASE"
    t.string "email", null: false, collation: "NOCASE"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "is_admin", default: false
    t.integer "articles_count", default: 0, null: false
    t.index ["email"], name: "ux_users_email", unique: true
    t.index ["username"], name: "ux_users_username", unique: true
  end

  add_foreign_key "articles", "users", column: "author_id", on_delete: :cascade
  add_foreign_key "categorizations", "articles", on_delete: :cascade
  add_foreign_key "categorizations", "categories", on_delete: :cascade
  add_foreign_key "comments", "articles", on_delete: :cascade
  add_foreign_key "comments", "users", column: "author_id", on_delete: :cascade
end
