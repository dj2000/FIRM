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

ActiveRecord::Schema.define(version: 20160205141711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agent_clients", force: true do |t|
    t.integer  "agent_id"
    t.integer  "client_id"
    t.date     "agentDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agents", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "middleInit"
    t.string   "company"
    t.string   "phoneH"
    t.string   "phoneW"
    t.string   "phoneC"
    t.string   "email"
    t.text     "mailAddress"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "mailingList"
  end

  create_table "appointments", force: true do |t|
    t.integer  "inspRequest_id"
    t.datetime "schedStart"
    t.datetime "schedEnd"
    t.boolean  "allDay"
    t.integer  "inspector_id"
    t.string   "contact"
    t.float    "inspFee"
    t.boolean  "prepaid"
    t.string   "pmtMethod"
    t.string   "pmtRef"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "svcArea_id"
    t.float    "amount_received"
    t.boolean  "is_insurance"
    t.text     "concerns"
  end

  create_table "bids", force: true do |t|
    t.integer  "inspection_id"
    t.decimal  "costRepair"
    t.decimal  "feeSeismicUpg"
    t.decimal  "feeAdmin"
    t.integer  "payPlan_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.float    "balance"
  end

  create_table "block_out_periods", force: true do |t|
    t.datetime "schedStart"
    t.datetime "schedEnd"
    t.boolean  "allDay"
    t.integer  "inspector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_properties", force: true do |t|
    t.integer  "client_id"
    t.integer  "property_id"
    t.string   "clientType"
    t.date     "typeDate"
    t.string   "occupiedBy"
    t.boolean  "escrow",      default: false
    t.date     "escrowDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "middleInit"
    t.string   "phoneH"
    t.string   "phoneW"
    t.string   "phoneC"
    t.string   "email"
    t.text     "mailAddress"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "mailingList"
    t.boolean  "is_opt_out_mailer"
    t.string   "client_type"
    t.string   "company_name"
    t.string   "of_type"
    t.text     "notes"
  end

  create_table "comm_histories", force: true do |t|
    t.integer  "inspection_id"
    t.string   "caller"
    t.string   "recipient"
    t.text     "callSummary"
    t.string   "callOutcome"
    t.datetime "callBackDate"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bid_id"
    t.datetime "call_time"
    t.boolean  "is_completed",  default: false
  end

  create_table "commission_payment_details", force: true do |t|
    t.integer  "inspector_id"
    t.integer  "contract_id"
    t.decimal  "amount"
    t.date     "paid_date"
    t.string   "payment_reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "commission_rate"
    t.decimal  "project_cost"
  end

  create_table "commission_rates", force: true do |t|
    t.integer  "scale_start"
    t.integer  "scale_end"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commissions", force: true do |t|
    t.integer  "inspector_id"
    t.integer  "commission_rate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "percentage"
  end

  create_table "contracts", force: true do |t|
    t.integer  "bid_id"
    t.date     "date"
    t.string   "signedBy"
    t.string   "acceptedBy"
    t.date     "dateSigned"
    t.decimal  "downPmtAmt"
    t.date     "downPmtDate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmed_by"
    t.date     "accepted_date"
    t.string   "title"
    t.string   "status"
    t.text     "notes"
    t.string   "deposit_payment_method"
  end

  create_table "credit_notes", force: true do |t|
    t.string   "reference"
    t.date     "date"
    t.integer  "invoice_id"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crew_skills", force: true do |t|
    t.integer  "crew_id"
    t.string   "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crews", force: true do |t|
    t.string   "foreman"
    t.integer  "size"
    t.boolean  "double_book"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "documents", force: true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_type"
  end

  create_table "draftsmen", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "engineers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "i_fee_schedules", force: true do |t|
    t.boolean  "feeActive"
    t.date     "effectiveFrom"
    t.decimal  "ownerOccRate"
    t.decimal  "sfrBaseRate"
    t.decimal  "sfrIncRate"
    t.decimal  "mfrBaseRate"
    t.decimal  "mfrIncRate"
    t.decimal  "insBaseRate"
    t.decimal  "insIncRate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insp_comm_scales", force: true do |t|
    t.integer  "inspector_id"
    t.decimal  "scaleStart"
    t.decimal  "scaleEnd"
    t.decimal  "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insp_requests", force: true do |t|
    t.datetime "callTime"
    t.string   "callerType"
    t.string   "referalSource"
    t.integer  "client_id"
    t.integer  "agent_id"
    t.integer  "property_id"
    t.string   "selectInsp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insp_skills", force: true do |t|
    t.integer  "inspector_id"
    t.string   "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspections", force: true do |t|
    t.integer  "appointment_id"
    t.string   "fCondition"
    t.boolean  "businessCards"
    t.integer  "nOD"
    t.integer  "nOG"
    t.boolean  "paid"
    t.string   "footprintURL"
    t.boolean  "repairs"
    t.boolean  "interiorAccess"
    t.boolean  "verifiedReport"
    t.boolean  "verifiedComp"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "report_file_name"
    t.string   "report_content_type"
    t.integer  "report_file_size"
    t.datetime "report_updated_at"
    t.string   "name"
    t.string   "completed_appointment_sheet_file_name"
    t.string   "completed_appointment_sheet_content_type"
    t.integer  "completed_appointment_sheet_file_size"
    t.datetime "completed_appointment_sheet_updated_at"
    t.string   "client_information_sheet_file_name"
    t.string   "client_information_sheet_content_type"
    t.integer  "client_information_sheet_file_size"
    t.datetime "client_information_sheet_updated_at"
    t.string   "footprint_diagram_file_name"
    t.string   "footprint_diagram_content_type"
    t.integer  "footprint_diagram_file_size"
    t.datetime "footprint_diagram_updated_at"
  end

  create_table "inspectors", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "middleInit"
    t.boolean  "senior"
    t.string   "phoneH"
    t.string   "phoneC"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.boolean  "is_active",  default: true
  end

  create_table "invoices", force: true do |t|
    t.string   "reference"
    t.string   "invoice_type"
    t.string   "inspection_id"
    t.text     "description"
    t.date     "invoiceDate"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "due_date"
    t.integer  "project_id"
  end

  create_table "pay_plans", force: true do |t|
    t.integer  "jobMinAmt"
    t.integer  "jobMaxAmt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deposit"
    t.string   "title"
    t.string   "deposit_label"
    t.float    "deposit_limit"
  end

  create_table "payments", force: true do |t|
    t.string   "title"
    t.integer  "value"
    t.integer  "pay_plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment_type"
  end

  create_table "permit_informations", force: true do |t|
    t.integer  "valuation"
    t.boolean  "replacement"
    t.string   "type_of_replacement"
    t.integer  "amount"
    t.boolean  "engineering"
    t.integer  "engineer_id"
    t.boolean  "units"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permits", force: true do |t|
    t.string   "reference"
    t.date     "issueDate"
    t.string   "issuedBy"
    t.string   "status"
    t.decimal  "valuation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "permit_information_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "pmt_schedules", force: true do |t|
    t.integer  "contract_id"
    t.integer  "pmtNumber"
    t.date     "pmtDate"
    t.decimal  "pmtAmount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proj_insps", force: true do |t|
    t.integer  "project_id"
    t.string   "reference"
    t.date     "scheduleDate"
    t.string   "inspectBy"
    t.date     "completeDate"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proj_scheds", force: true do |t|
    t.integer  "project_id"
    t.integer  "crew_id"
    t.date     "schedule_start_date"
    t.time     "startTime"
    t.time     "endTime"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "schedule_end_date"
  end

  create_table "project_payment_schedules", force: true do |t|
    t.integer  "project_id"
    t.integer  "payment_id"
    t.string   "payment_schedule"
    t.float    "amount"
    t.string   "payment_type"
    t.date     "invoice_date"
    t.boolean  "paid"
    t.date     "date_paid"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.date     "vcDate"
    t.integer  "contract_id"
    t.decimal  "jobCost"
    t.date     "scheduleBy"
    t.string   "schedulePref"
    t.integer  "estDuration"
    t.date     "scheduleStart"
    t.date     "scheduleEnd"
    t.string   "authorizedBy"
    t.date     "authorizedOn"
    t.integer  "crew_id"
    t.boolean  "verifiedAccess"
    t.boolean  "verifiedEW"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.date     "schedule_pref_start"
    t.date     "schedule_pref_end"
    t.boolean  "permit"
    t.integer  "primary_crew_id"
    t.boolean  "plot_plans",          default: false
    t.boolean  "drawings",            default: false
    t.string   "option"
    t.boolean  "ready_to_process"
    t.string   "status",              default: "Open"
    t.boolean  "send_to_crew",        default: false
  end

  create_table "properties", force: true do |t|
    t.string   "number"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "crossStreet"
    t.integer  "mapPage"
    t.integer  "yearBuilt"
    t.integer  "size"
    t.integer  "stories"
    t.string   "prop_type"
    t.integer  "units"
    t.integer  "gndUnits"
    t.string   "lotType"
    t.string   "foundation"
    t.boolean  "cdo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "occupied_by"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "hpoz"
  end

  create_table "receipts", force: true do |t|
    t.string   "reference"
    t.date     "date"
    t.integer  "invoice_id"
    t.decimal  "amount"
    t.string   "recBy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name",        null: false
    t.string   "title",       null: false
    t.text     "description", null: false
    t.text     "the_role",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "skill"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "svc_areas", force: true do |t|
    t.integer  "zip"
    t.string   "city"
    t.string   "state"
    t.boolean  "serviced"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes",      limit: 25
  end

  create_table "svc_criteria", force: true do |t|
    t.boolean  "propRes"
    t.boolean  "propComm"
    t.string   "foundation"
    t.integer  "yearBuilt"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prevInsp"
    t.integer  "hpoz"
    t.integer  "cdo"
    t.integer  "ownerOcc"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role_id"
    t.string   "status",                 default: "Pending"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
