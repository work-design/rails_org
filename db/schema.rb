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

ActiveRecord::Schema.define(version: 2019_03_04_134752) do

  create_table "job_descriptions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "department_id"
    t.text "requirements"
    t.text "advanced_requirements"
    t.string "english_requirement"
    t.string "degree_requirement"
    t.text "duties"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "salary_min"
    t.integer "salary_max"
    t.index ["department_id"], name: "index_job_descriptions_on_department_id"
  end

  create_table "job_transfers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "to_office_id"
    t.bigint "to_department_id"
    t.integer "from_office_id"
    t.integer "from_department_id"
    t.date "transfer_on"
    t.string "reason_note", limit: 4096
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "comment", limit: 4096
    t.integer "to_job_title_id"
    t.integer "from_job_title_id"
    t.index ["member_id"], name: "index_job_transfers_on_member_id"
    t.index ["to_department_id"], name: "index_job_transfers_on_to_department_id"
    t.index ["to_office_id"], name: "index_job_transfers_on_to_office_id"
  end

  create_table "members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "enabled", default: true
    t.string "type"
    t.string "title"
    t.date "join_on"
    t.bigint "office_id"
    t.bigint "department_id"
    t.string "name"
    t.string "attendance_number"
    t.string "email"
    t.string "skype"
    t.text "profession"
    t.date "intern_begin_on"
    t.date "formal_on"
    t.string "join_status"
    t.string "number"
    t.text "experience"
  end

  create_table "offices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address", limit: 512
    t.string "absence_email"
    t.bigint "leader_id"
    t.integer "members_count", default: 0
    t.integer "deputy_leader_id"
    t.string "name_short"
    t.string "timezone"
    t.string "locale"
    t.string "contact"
    t.string "recruitment"
    t.index ["leader_id"], name: "index_offices_on_leader_id"
  end


  create_table "resign_reason_hierarchies", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "resign_reason_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "resign_reason_desc_idx"
  end

  create_table "resign_reasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_id"
    t.integer "position", default: 1
    t.integer "resigns_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_resign_reasons_on_parent_id"
  end

  create_table "resign_resign_reasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "resign_id"
    t.bigint "resign_reason_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resign_id"], name: "index_resign_resign_reasons_on_resign_id"
    t.index ["resign_reason_id"], name: "index_resign_resign_reasons_on_resign_reason_id"
  end

  create_table "resigns", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "resign_reason_id"
    t.date "leave_on"
    t.string "reason_note", limit: 4096
    t.string "handover_note", limit: 4096
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "comment", limit: 4096
    t.index ["member_id"], name: "index_resigns_on_member_id"
    t.index ["resign_reason_id"], name: "index_resigns_on_resign_reason_id"
  end

  create_table "sm_settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "access_token"
    t.datetime "limit_at"
    t.boolean "working"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "department_id"
    t.bigint "office_id"
    t.bigint "member_id"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supporter_id"
    t.index ["department_id"], name: "index_supports_on_department_id"
    t.index ["member_id"], name: "index_supports_on_member_id"
    t.index ["office_id"], name: "index_supports_on_office_id"
    t.index ["supporter_id"], name: "index_supports_on_supporter_id"
  end

  create_table "tutorials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "tutor_id"
    t.string "kind"
    t.string "state"
    t.string "accepted_status"
    t.string "verified"
    t.date "start_on"
    t.date "finish_on"
    t.string "performance"
    t.integer "allowance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "note", limit: 4096
    t.string "comment", limit: 4096
    t.index ["member_id"], name: "index_tutorials_on_member_id"
    t.index ["tutor_id"], name: "index_tutorials_on_tutor_id"
  end

end
