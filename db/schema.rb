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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110222155131) do

  create_table "bridges", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bridge_table"
    t.text     "bridge_stats"
  end

  create_table "competencies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
  end

  create_table "competencies_partners", :id => false, :force => true do |t|
    t.integer "partner_id"
    t.integer "competency_id"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "partner_id"
    t.integer  "telephone_no"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "county"
    t.string   "post_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holidays", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "work_plan_id"
  end

  create_table "partners", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "employee_no"
    t.boolean  "is_manager"
    t.boolean  "is_temp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shift_templates", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weekly_rota_id"
    t.boolean  "is_active"
  end

  create_table "shifts", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partner_id"
    t.string   "color"
    t.integer  "shift_type", :default => 1
  end

  create_table "weekly_rotas", :force => true do |t|
    t.integer  "work_plan_id"
    t.integer  "sequence_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_plans", :force => true do |t|
    t.integer  "partner_id"
    t.integer  "starting_week_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "holiday_entitle"
    t.integer  "holiday_taken"
    t.integer  "holiday_booked"
  end

end
