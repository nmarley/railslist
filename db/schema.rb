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

ActiveRecord::Schema.define(version: 20130910002445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingredients", ["name"], name: "index_ingredients_on_name", unique: true, using: :btree

  create_table "items", force: true do |t|
    t.text     "content"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "private",    default: false
  end

  add_index "lists", ["user_id", "created_at"], name: "index_lists_on_user_id_and_created_at", using: :btree

  create_table "recipe_ingredients", force: true do |t|
    t.integer "recipe_id",     null: false
    t.integer "ingredient_id", null: false
    t.string  "amount"
  end

  add_index "recipe_ingredients", ["ingredient_id", "recipe_id"], name: "index_recipe_ingredients_on_ingredient_id_and_recipe_id", unique: true, using: :btree

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipes", ["name"], name: "index_recipes_on_name", unique: true, using: :btree

  create_table "user_list_permissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "list_id"
    t.string   "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_list_permissions", ["list_id"], name: "index_user_list_permissions_on_list_id", using: :btree
  add_index "user_list_permissions", ["user_id"], name: "index_user_list_permissions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",           default: ""
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "items", "lists", :name => "items_list_id_fk", :dependent => :delete

  add_foreign_key "lists", "users", :name => "lists_user_id_fk", :dependent => :delete

end
