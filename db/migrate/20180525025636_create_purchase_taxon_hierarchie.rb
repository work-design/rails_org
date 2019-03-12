class CreatePurchaseTaxonHierarchie < ActiveRecord::Migration[5.2]
  def change

  create_table "absences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "kind"
    t.string "type"
    t.bigint "member_id"
    t.float "hours"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "note", limit: 2048
    t.string "comment", limit: 2048
    t.integer "auditor_id"
    t.string "compensatory"
    t.index ["member_id"], name: "index_absences_on_member_id"
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "area_id"
    t.bigint "user_id"
    t.bigint "buyer_id"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_addresses_on_area_id"
    t.index ["buyer_id"], name: "index_addresses_on_buyer_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nation", default: ""
    t.string "province", default: ""
    t.string "city", default: ""
    t.string "district", default: ""
    t.boolean "published", default: true
    t.boolean "popular", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendance_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.datetime "record_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "processed", default: false
    t.string "status"
    t.bigint "attendance_id"
    t.string "kind"
    t.index ["attendance_id"], name: "index_attendance_logs_on_attendance_id"
  end

  create_table "attendances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.float "total_hours"
    t.integer "late_minutes"
    t.integer "leave_minutes"
    t.float "overtime_hours"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "attend_on"
    t.datetime "interval_start_at"
    t.datetime "interval_finish_at"
    t.index ["member_id"], name: "index_attendances_on_member_id"
  end

  create_table "audits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "auditable_type"
    t.bigint "auditable_id"
    t.string "operator_type"
    t.bigint "operator_id"
    t.string "action"
    t.string "audited_changes", limit: 4096
    t.string "related_changes", limit: 4096
    t.string "unconfirmed_changes", limit: 4096
    t.string "note", limit: 1024
    t.string "remote_ip"
    t.string "controller_path"
    t.string "action_name"
    t.string "extra", limit: 4096
    t.datetime "created_at", null: false
    t.index ["auditable_type", "auditable_id"], name: "index_audits_on_auditable_type_and_auditable_id"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["operator_type", "operator_id"], name: "index_audits_on_operator_type_and_operator_id"
  end

  create_table "cart_item_serves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "cart_item_id"
    t.bigint "serve_id"
    t.string "scope"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_cart_item_serves_on_cart_item_id"
    t.index ["serve_id"], name: "index_cart_item_serves_on_serve_id"
  end

  create_table "cart_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "buyer_id"
    t.string "good_type"
    t.bigint "good_id"
    t.string "session_id", limit: 128
    t.string "status"
    t.integer "quantity"
    t.string "extra", limit: 1024
    t.boolean "checked", default: false
    t.boolean "myself"
    t.boolean "archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_cart_items_on_buyer_id"
    t.index ["good_type", "good_id"], name: "index_cart_items_on_good_type_and_good_id"
    t.index ["user_id"], name: "index_cart_items_on_user_id"
  end

  create_table "crm_performs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "perform_type"
    t.bigint "perform_id"
    t.bigint "member_id"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_crm_performs_on_member_id"
    t.index ["perform_type", "perform_id"], name: "index_crm_performs_on_perform_type_and_perform_id"
  end

  create_table "crm_permits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "department_id"
    t.bigint "office_id"
    t.bigint "member_id"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_crm_permits_on_department_id"
    t.index ["member_id"], name: "index_crm_permits_on_member_id"
    t.index ["office_id"], name: "index_crm_permits_on_office_id"
  end

  create_table "data_lists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "comment", limit: 4096
    t.string "type"
    t.string "parameters", limit: 1024
    t.string "columns", limit: 1024
    t.string "data_table"
    t.string "export_excel"
    t.string "export_pdf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "department_hierarchies", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "department_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "department_desc_idx"
  end

  create_table "department_journals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "department_id"
    t.bigint "journal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "present_member"
    t.integer "needed_member"
    t.index ["department_id"], name: "index_department_journals_on_department_id"
    t.index ["journal_id"], name: "index_department_journals_on_journal_id"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_id"
    t.bigint "leader_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "present_member"
    t.integer "needed_member"
    t.string "collective_email"
    t.integer "members_count", default: 0
    t.string "type"
    t.integer "old_section_id"
    t.integer "old_group_id"
    t.integer "old_department_id"
    t.integer "old_parent_id"
    t.boolean "enabled", default: true
    t.index ["leader_id"], name: "index_departments_on_leader_id"
    t.index ["parent_id"], name: "index_departments_on_parent_id"
  end

  create_table "dinners", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "office_id"
    t.integer "order_items_count", default: 0
    t.bigint "provider_id"
    t.index ["office_id"], name: "index_dinners_on_office_id"
    t.index ["provider_id"], name: "index_dinners_on_provider_id"
  end

  create_table "documents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "editors", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.string "title"
    t.string "firstname"
    t.string "middlename"
    t.string "lastname", null: false
    t.text "affiliation", limit: 16777215, null: false
    t.string "phone"
    t.string "fax"
    t.string "country"
    t.string "email", collation: "utf8_general_ci"
    t.string "website"
    t.text "interests", limit: 16777215
    t.string "alternative_email"
    t.string "alternative_website"
    t.boolean "show_badge", default: false, null: false
    t.string "badge_url"
    t.index ["email"], name: "un_email", unique: true
    t.index ["firstname", "middlename", "lastname"], name: "idx_names"
  end

  create_table "editors_boards", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.integer "journal_id", null: false, unsigned: true
    t.integer "section_id", unsigned: true
    t.integer "special_issue_id", unsigned: true
    t.string "boardtype", null: false
    t.index ["journal_id", "section_id", "special_issue_id", "boardtype"], name: "un_editors_boards", unique: true
    t.index ["section_id"], name: "editors_boards_fk_section_id"
    t.index ["special_issue_id"], name: "editors_boards_fk_special_issue_id"
  end

  create_table "editors_rel", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.integer "editor_id", null: false, unsigned: true
    t.integer "role_id", null: false, unsigned: true
    t.integer "board_id", unsigned: true
    t.integer "position", limit: 2, default: 0
    t.string "notes"
    t.boolean "display_public_email", default: true
    t.index ["board_id"], name: "editors_rel_fk_board_id"
    t.index ["editor_id"], name: "editors_rel_fk_editor_id"
    t.index ["role_id"], name: "editors_rel_fk_role_id"
  end

  create_table "exams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "lesson_paper_id"
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lesson_id"
    t.string "onedrive_item"
    t.string "link"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.string "entity_id"
    t.string "state"
    t.string "answer_id"
    t.string "answer_detail", limit: 4096
    t.boolean "referenced", default: false
    t.string "answer_mark"
    t.index ["lesson_id"], name: "index_exams_on_lesson_id"
    t.index ["lesson_paper_id"], name: "index_exams_on_lesson_paper_id"
    t.index ["member_id"], name: "index_exams_on_member_id"
  end

  create_table "expense_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "expense_id"
    t.bigint "member_id"
    t.bigint "payment_method_id"
    t.decimal "amount", precision: 10, scale: 2
    t.decimal "cost", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["expense_id"], name: "index_expense_members_on_expense_id"
    t.index ["member_id"], name: "index_expense_members_on_member_id"
    t.index ["payment_method_id"], name: "index_expense_members_on_payment_method_id"
  end

  create_table "expenses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "type"
    t.string "subject"
    t.string "state"
    t.decimal "amount", precision: 10, scale: 2
    t.string "comment", limit: 4096
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_expenses_on_creator_id"
  end

  create_table "extra_days", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "the_day"
    t.string "name"
    t.string "kind", comment: "holiday, workday"
    t.string "scope"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "financial_months", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "begin_date"
    t.date "end_date"
    t.string "working_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  create_table "goods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "sku"
    t.string "name"
    t.decimal "quantity", precision: 10
    t.string "unit"
    t.decimal "price", precision: 10
    t.integer "sales_count"
    t.boolean "published", default: true
    t.bigint "promote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["promote_id"], name: "index_goods_on_promote_id"
    t.index ["sku"], name: "index_goods_on_sku"
  end

  create_table "govern_taxons", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "position", default: 0
    t.integer "governs_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
  end

  create_table "governs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "position", default: 0
    t.integer "govern_taxon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["govern_taxon_id"], name: "index_governs_on_govern_taxon_id"
  end

  create_table "idatabases", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_system"
    t.text "description"
    t.string "url"
    t.string "name_short", limit: 50
    t.integer "flag_id"
    t.text "comment"
    t.index ["flag_id"], name: "flag_id"
    t.index ["name_system"], name: "un_name_system", unique: true
  end

  create_table "idatabases_relations", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.integer "journal_id", null: false, unsigned: true
    t.integer "database_id", null: false, unsigned: true
    t.string "url"
    t.integer "journals_status_id", default: 3, null: false, unsigned: true
    t.timestamp "last_update"
    t.text "comment"
    t.datetime "date"
    t.index ["database_id"], name: "idatabases_relations_fk_database_id"
    t.index ["journal_id"], name: "idatabases_relations_fk_journal_id"
    t.index ["journals_status_id"], name: "idatabases_relations_fk_journals_status_id"
  end

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

  create_table "job_titles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "department_id"
    t.string "name"
    t.integer "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_job_titles_on_department_id"
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

  create_table "journal_transfers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "from_id"
    t.bigint "to_id"
    t.string "state"
    t.string "comment", limit: 1024
    t.string "transfer_url", limit: 512
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "journal_id"
    t.index ["from_id"], name: "index_journal_transfers_on_from_id"
    t.index ["journal_id"], name: "index_journal_transfers_on_journal_id"
    t.index ["to_id"], name: "index_journal_transfers_on_to_id"
  end

  create_table "journals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name_full"
    t.string "name_short"
    t.string "name_system"
    t.string "name_iso4"
    t.string "name_pubmed"
    t.string "issn_electronic"
    t.boolean "public_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "specific", default: false
  end

  create_table "lesson_grants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "lesson_id"
    t.bigint "department_id"
    t.bigint "band_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_lesson_grants_on_band_id"
    t.index ["department_id"], name: "index_lesson_grants_on_department_id"
    t.index ["lesson_id"], name: "index_lesson_grants_on_lesson_id"
  end

  create_table "lesson_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "lesson_id"
    t.bigint "member_id"
    t.string "state"
    t.string "watch_ids"
    t.boolean "attended", default: false
    t.integer "score"
    t.string "comment", limit: 4096
    t.string "quit_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "assigned_status"
    t.string "job_id"
    t.string "old_assigned_status"
    t.string "old_status"
    t.index ["lesson_id"], name: "index_lesson_members_on_lesson_id"
    t.index ["member_id"], name: "index_lesson_members_on_member_id"
  end

  create_table "lesson_papers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "lesson_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.string "entity_id"
    t.string "type"
    t.index ["lesson_id"], name: "index_lesson_papers_on_lesson_id"
  end

  create_table "lesson_taxons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.bigint "lesson_taxon_id"
    t.string "title"
    t.string "description", limit: 4096
    t.integer "position", default: 1
    t.bigint "author_id"
    t.bigint "lecturer_id"
    t.string "repeat_type"
    t.string "repeat_days"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.string "meeting_room"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lesson_members_count", default: 0
    t.integer "limit_people"
    t.string "video_link"
    t.string "en_video_link"
    t.string "document_link"
    t.boolean "compulsory", default: false
    t.index ["author_id"], name: "index_lessons_on_author_id"
    t.index ["lecturer_id"], name: "index_lessons_on_lecturer_id"
    t.index ["lesson_taxon_id"], name: "index_lessons_on_lesson_taxon_id"
  end

  create_table "log_mailers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "message_object_id"
    t.string "mailer"
    t.string "action"
    t.string "params"
    t.string "mail_to"
    t.string "cc_to"
    t.string "sent_status"
    t.string "sent_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "log_records", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "path"
    t.string "controller"
    t.string "action"
    t.string "params", limit: 2048
    t.string "headers", limit: 4096
    t.string "cookie", limit: 2048
    t.string "session", limit: 2048
    t.string "exception", limit: 10240
    t.string "exception_object"
    t.text "exception_backtrace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_hierarchies", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "officer_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "officer_desc_idx"
  end

  create_table "members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "parent_id"
    t.boolean "enabled", default: true
    t.string "type"
    t.string "title"
    t.date "join_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "office_id"
    t.bigint "department_id"
    t.string "name"
    t.string "extra_parent_ids"
    t.string "department_ancestors"
    t.string "attendance_number"
    t.time "off_time"
    t.time "on_time"
    t.string "email"
    t.integer "old_group_id"
    t.integer "old_section_id"
    t.string "old_status_id"
    t.time "next_on_time"
    t.time "next_off_time"
    t.bigint "job_title_id"
    t.string "skype"
    t.text "profession"
    t.date "intern_begin_on"
    t.date "probation_one_on"
    t.date "probation_two_on"
    t.date "formal_on"
    t.integer "children_count"
    t.string "join_status"
    t.string "number"
    t.index ["department_id"], name: "index_members_on_department_id"
    t.index ["email"], name: "index_members_on_email"
    t.index ["job_title_id"], name: "index_members_on_job_title_id"
    t.index ["office_id"], name: "index_members_on_office_id"
    t.index ["parent_id"], name: "index_members_on_parent_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "notification_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "showtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accept_email", default: true
    t.string "notifiable_types"
    t.index ["receiver_type", "receiver_id"], name: "index_notification_settings_on_receiver_type_and_receiver_id"
  end

  create_table "notifications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "state", default: 0
    t.string "title"
    t.string "body", limit: 5000
    t.string "link"
    t.datetime "sent_at"
    t.string "sent_result"
    t.datetime "read_at"
    t.string "notifiable_type"
    t.integer "notifiable_id"
    t.datetime "sending_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verbose", default: false
    t.string "cc_emails"
    t.string "code"
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["receiver_type", "receiver_id"], name: "index_notifications_on_receiver_type_and_receiver_id"
  end

  create_table "notify_settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "notifiable_type"
    t.string "code"
    t.string "notify_mailer"
    t.string "notify_method"
    t.string "only_verbose_columns"
    t.string "except_verbose_columns"
    t.string "cc_emails"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oauth_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "type"
    t.string "uid"
    t.string "name"
    t.string "avatar_url"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token", limit: 4096
    t.string "code"
    t.datetime "expires_at"
    t.index ["user_id"], name: "index_oauth_users_on_user_id"
  end

  create_table "offices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address", limit: 512
    t.string "address_cn", limit: 512
    t.string "country"
    t.string "city"
    t.string "floor"
    t.string "absence_email"
    t.bigint "leader_id"
    t.integer "members_count", default: 0
    t.string "lunch_time"
    t.integer "deputy_leader_id"
    t.string "name_short"
    t.index ["leader_id"], name: "index_offices_on_leader_id"
  end

  create_table "order_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "cart_item_id"
    t.string "good_type"
    t.bigint "good_id"
    t.integer "quantity"
    t.decimal "pure_price", precision: 10, scale: 2
    t.decimal "promote_sum", precision: 10, scale: 2
    t.decimal "serve_sum", precision: 10, scale: 2
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.index ["cart_item_id"], name: "index_order_items_on_cart_item_id"
    t.index ["good_type", "good_id"], name: "index_order_items_on_good_type_and_good_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "order_promotes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "order_item_id"
    t.bigint "promote_id"
    t.bigint "promote_charge_id"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_promotes_on_order_id"
    t.index ["order_item_id"], name: "index_order_promotes_on_order_item_id"
    t.index ["promote_charge_id"], name: "index_order_promotes_on_promote_charge_id"
    t.index ["promote_id"], name: "index_order_promotes_on_promote_id"
  end

  create_table "order_serves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "order_item_id"
    t.bigint "serve_id"
    t.bigint "serve_charge_id"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_serves_on_order_id"
    t.index ["order_item_id"], name: "index_order_serves_on_order_item_id"
    t.index ["serve_charge_id"], name: "index_order_serves_on_serve_charge_id"
    t.index ["serve_id"], name: "index_order_serves_on_serve_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "buyer_id"
    t.string "uuid", null: false
    t.integer "state", default: 0
    t.decimal "amount", precision: 10, scale: 2
    t.decimal "received_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "subtotal", precision: 10, scale: 2
    t.decimal "pure_serve_sum", precision: 10, scale: 2
    t.decimal "pure_promote_sum", precision: 10, scale: 2
    t.decimal "serve_sum", precision: 10, scale: 2
    t.decimal "promote_sum", precision: 10, scale: 2
    t.string "currency"
    t.integer "payment_id"
    t.string "payment_type"
    t.integer "payment_status"
    t.boolean "myself"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payment_strategy_id"
    t.string "note", limit: 4096
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
    t.index ["payment_strategy_id"], name: "index_orders_on_payment_strategy_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "overtimes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.string "state"
    t.string "note", limit: 1024
    t.string "comment", limit: 1024
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "hours"
    t.integer "auditor_id"
    t.index ["member_id"], name: "index_overtimes_on_member_id"
  end

  create_table "payment_methods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.string "account_name"
    t.string "account_num"
    t.string "bank"
    t.text "extra"
    t.boolean "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id"
    t.boolean "myself"
    t.index ["creator_id"], name: "index_payment_methods_on_creator_id"
  end

  create_table "payment_orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "payment_id"
    t.bigint "order_id"
    t.decimal "order_amount", precision: 10, scale: 2
    t.decimal "check_amount", precision: 10, scale: 2
    t.integer "state", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payment_orders_on_order_id"
    t.index ["payment_id"], name: "index_payment_orders_on_payment_id"
  end

  create_table "payment_references", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "payment_method_id"
    t.bigint "buyer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_payment_references_on_buyer_id"
    t.index ["payment_method_id"], name: "index_payment_references_on_payment_method_id"
    t.index ["user_id"], name: "index_payment_references_on_user_id"
  end

  create_table "payment_strategies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "strategy"
    t.integer "period", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.decimal "total_amount", precision: 10, scale: 2
    t.decimal "fee_amount", precision: 10, scale: 2
    t.decimal "income_amount", precision: 10, scale: 2
    t.decimal "checked_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "adjust_amount", precision: 10, scale: 2, default: "0.0"
    t.string "payment_uuid"
    t.string "notify_type"
    t.datetime "notified_at"
    t.string "pay_status"
    t.string "sign"
    t.string "seller_identifier"
    t.string "buyer_name"
    t.string "buyer_identifier"
    t.string "buyer_bank"
    t.integer "user_id"
    t.string "currency"
    t.integer "state", default: 0
    t.string "comment"
    t.bigint "payment_method_id"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_payments_on_creator_id"
    t.index ["payment_method_id"], name: "index_payments_on_payment_method_id"
  end

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "real_name"
    t.string "private_email"
    t.string "mobile"
    t.string "gender"
    t.string "birthday_type"
    t.date "birthday"
    t.string "highest_education"
    t.string "degree"
    t.string "major"
    t.text "work_experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resume_link"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "promote_buyers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "buyer_id"
    t.bigint "promote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_promote_buyers_on_buyer_id"
    t.index ["promote_id"], name: "index_promote_buyers_on_promote_id"
  end

  create_table "promote_charges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "promote_id"
    t.decimal "min", precision: 10, scale: 2, default: "0.0"
    t.decimal "max", precision: 10, scale: 2, default: "99999999.99"
    t.decimal "price", precision: 10, scale: 2
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["promote_id"], name: "index_promote_charges_on_promote_id"
  end

  create_table "promote_goods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "good_type"
    t.bigint "good_id"
    t.bigint "promote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_type", "good_id"], name: "index_promote_goods_on_good_type_and_good_id"
    t.index ["promote_id"], name: "index_promote_goods_on_promote_id"
  end

  create_table "promotes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.string "unit"
    t.string "name"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.string "scope"
    t.boolean "verified", default: false
    t.boolean "overall", default: false
    t.boolean "contain_max", default: false
    t.integer "sequence", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "area_id"
    t.string "type"
    t.string "name"
    t.string "service_tel"
    t.string "service_qq"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_providers_on_area_id"
  end

  create_table "purchase_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.decimal "price", precision: 10, scale: 2
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "purchase_id"
    t.index ["purchase_id"], name: "index_purchase_items_on_purchase_id"
  end

  create_table "purchase_offices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "purchase_id"
    t.bigint "office_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_id"], name: "index_purchase_offices_on_office_id"
    t.index ["purchase_id"], name: "index_purchase_offices_on_purchase_id"
  end

  create_table "purchase_taxon_hierarchies", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "purchase_taxon_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "purchase_taxon_desc_idx"
  end

  create_table "purchase_taxons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "position", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.index ["parent_id"], name: "index_purchase_taxons_on_parent_id"
  end

  create_table "purchases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "office_id"
    t.bigint "purchase_taxon_id"
    t.string "subject"
    t.string "state"
    t.string "comment", limit: 1024
    t.string "payment_type"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.bigint "payment_method_id"
    t.index ["member_id"], name: "index_purchases_on_member_id"
    t.index ["office_id"], name: "index_purchases_on_office_id"
    t.index ["payment_method_id"], name: "index_purchases_on_payment_method_id"
    t.index ["purchase_taxon_id"], name: "index_purchases_on_purchase_taxon_id"
  end

  create_table "record_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "record_list_id"
    t.string "fields", limit: 10240
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_list_id"], name: "index_record_items_on_record_list_id"
  end

  create_table "record_lists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "data_list_id"
    t.string "columns", limit: 4096
    t.string "parameters", limit: 1024
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "done"
    t.index ["data_list_id"], name: "index_record_lists_on_data_list_id"
  end

  create_table "refunds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "payment_id"
    t.bigint "operator_id"
    t.string "type"
    t.decimal "total_amount", precision: 10, scale: 2
    t.string "buyer_identifier"
    t.string "comment", limit: 512
    t.integer "state", default: 0
    t.datetime "refunded_at"
    t.string "reason", limit: 512
    t.string "currency"
    t.string "refund_uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operator_id"], name: "index_refunds_on_operator_id"
    t.index ["order_id"], name: "index_refunds_on_order_id"
    t.index ["payment_id"], name: "index_refunds_on_payment_id"
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

  create_table "role_rules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "role_id"
    t.integer "rule_id"
    t.integer "govern_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["govern_id"], name: "index_role_rules_on_govern_id"
    t.index ["role_id"], name: "index_role_rules_on_role_id"
    t.index ["rule_id"], name: "index_role_rules_on_rule_id"
  end

  create_table "roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", limit: 1024
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "params"
    t.integer "govern_id"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["govern_id"], name: "index_rules_on_govern_id"
  end

  create_table "serve_charges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "serve_id"
    t.decimal "min", precision: 10, scale: 2, default: "0.0"
    t.decimal "max", precision: 10, scale: 2, default: "99999999.99"
    t.decimal "price", precision: 10, scale: 2
    t.decimal "base_price", precision: 10, scale: 2, default: "0.0"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serve_id"], name: "index_serve_charges_on_serve_id"
  end

  create_table "serve_goods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "good_type"
    t.bigint "good_id"
    t.bigint "serve_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_type", "good_id"], name: "index_serve_goods_on_good_type_and_good_id"
    t.index ["serve_id"], name: "index_serve_goods_on_serve_id"
  end

  create_table "serves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.string "unit"
    t.string "name"
    t.string "scope"
    t.string "extra"
    t.boolean "verified", default: false
    t.boolean "overall", default: true
    t.boolean "contain_max", default: false
    t.boolean "default", default: false
    t.string "deal_type"
    t.bigint "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_type", "deal_id"], name: "index_serves_on_deal_type_and_deal_id"
  end

  create_table "sync_audits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "operator_type"
    t.bigint "operator_id"
    t.string "synchro_type"
    t.bigint "synchro_id"
    t.string "operation"
    t.string "audited_changes", limit: 4096
    t.string "note", limit: 1024
    t.string "state"
    t.datetime "apply_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "destined_id"
    t.string "synchro_primary_key", default: "id"
    t.string "synchro_primary_value"
    t.index ["destined_id"], name: "index_sync_audits_on_destined_id"
    t.index ["operator_type", "operator_id"], name: "index_sync_audits_on_operator_type_and_operator_id"
    t.index ["synchro_type", "synchro_id"], name: "index_sync_audits_on_synchro_type_and_synchro_id"
  end

  create_table "table_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "table_list_id"
    t.string "fields", limit: 4096
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_list_id"], name: "index_table_items_on_table_list_id"
  end

  create_table "table_lists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "data_list_id"
    t.string "headers", limit: 4096
    t.string "footers", limit: 4096
    t.integer "table_items_count", default: 0
    t.string "parameters", limit: 1024
    t.boolean "done"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_list_id"], name: "index_table_lists_on_data_list_id"
  end

  create_table "teachers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "description", limit: 4096
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_teachers_on_member_id"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "train_exam_pagers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tutorials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "tutor_id"
    t.string "kind"
    t.string "state"
    t.string "accepted_status"
    t.string "verified"
    t.date "intern_begin_on"
    t.date "probation_begin_on"
    t.date "tutor_begin_on"
    t.date "accepted_on"
    t.string "performance"
    t.integer "allowance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "note", limit: 4096
    t.string "comment", limit: 4096
    t.index ["member_id"], name: "index_tutorials_on_member_id"
    t.index ["tutor_id"], name: "index_tutorials_on_tutor_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "email", limit: 100
    t.boolean "email_confirm", default: false
    t.string "mobile", limit: 20
    t.boolean "mobile_confirm", default: false
    t.string "password_digest"
    t.datetime "last_login_at"
    t.string "last_login_ip"
    t.boolean "disabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timezone"
    t.string "avatar_link"
    t.index ["email"], name: "index_users_on_email"
    t.index ["mobile"], name: "index_users_on_mobile"
  end

  create_table "verify_tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "type", limit: 100
    t.string "token"
    t.datetime "expired_at"
    t.integer "access_counter", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account"
    t.index ["user_id"], name: "index_verify_tokens_on_user_id"
  end

  create_table "who_roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "who_type"
    t.integer "who_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_who_roles_on_role_id"
    t.index ["who_type", "who_id"], name: "index_who_roles_on_who_type_and_who_id"
  end

  end
end
