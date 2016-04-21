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

ActiveRecord::Schema.define(version: 20160421071339) do

  create_table "companies", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "lastName",         limit: 255
    t.string   "firstName",        limit: 255
    t.string   "sin",              limit: 255
    t.date     "dateOfBirth"
    t.text     "reasonForLeaving", limit: 65535
    t.integer  "company_id",       limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "editor_id",        limit: 4
  end

  add_index "employees", ["company_id"], name: "index_employees_on_company_id", using: :btree
  add_index "employees", ["editor_id"], name: "index_employees_on_editor_id", using: :btree

  create_table "full_time_employees", force: :cascade do |t|
    t.date     "dateOfHire"
    t.date     "dateofTermination"
    t.decimal  "salary",                           precision: 10
    t.integer  "employee_id",            limit: 4
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.integer  "full_time_employees_id", limit: 4
    t.boolean  "verified",                                        default: false
  end

  add_index "full_time_employees", ["employee_id"], name: "index_full_time_employees_on_employee_id", using: :btree
  add_index "full_time_employees", ["full_time_employees_id"], name: "index_full_time_employees_on_full_time_employees_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.text     "employeeInfo",   limit: 65535
    t.text     "additionalInfo", limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "CRUD",           limit: 255
    t.string   "table",          limit: 255
    t.string   "who",            limit: 255
  end

  create_table "part_time_employees", force: :cascade do |t|
    t.date     "dateOfHire"
    t.date     "dateOfTermination"
    t.decimal  "hourlyRate",                       precision: 10
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.integer  "part_time_employees_id", limit: 4
    t.boolean  "verified",                                        default: false
    t.integer  "employee_id",            limit: 4
  end

  add_index "part_time_employees", ["employee_id"], name: "index_part_time_employees_on_employee_id", using: :btree
  add_index "part_time_employees", ["part_time_employees_id"], name: "index_part_time_employees_on_part_time_employees_id", using: :btree

  create_table "seasonals", force: :cascade do |t|
    t.string   "season",       limit: 255
    t.integer  "seasonYear",   limit: 4
    t.decimal  "piecePay",                 precision: 10
    t.integer  "employee_id",  limit: 4
    t.boolean  "verified"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "seasonals_id", limit: 4
  end

  add_index "seasonals", ["employee_id"], name: "index_seasonals_on_employee_id", using: :btree
  add_index "seasonals", ["seasonals_id"], name: "index_seasonals_on_seasonals_id", using: :btree

  create_table "time_cards", force: :cascade do |t|
    t.date     "dateOf"
    t.decimal  "sunday",                precision: 10
    t.decimal  "monday",                precision: 10
    t.decimal  "tuesday",               precision: 10
    t.decimal  "wednesday",             precision: 10
    t.decimal  "thursday",              precision: 10
    t.decimal  "friday",                precision: 10
    t.decimal  "saturday",              precision: 10
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "employee_id", limit: 4
  end

  add_index "time_cards", ["employee_id"], name: "index_time_cards_on_employee_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "userType",        limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "employees", "companies"
  add_foreign_key "full_time_employees", "employees"
  add_foreign_key "seasonals", "employees"
end
