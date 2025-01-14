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

ActiveRecord::Schema[7.0].define(version: 2023_08_09_143853) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "availability_weeks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "week_start"
    t.date "week_end"
    t.boolean "week_enabled"
    t.boolean "available_monday"
    t.boolean "available_tuesday"
    t.boolean "available_wednesday"
    t.boolean "available_thursday"
    t.boolean "available_friday"
    t.boolean "available_saturday"
    t.boolean "available_sunday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_availability_weeks_on_user_id"
  end

  create_table "availables", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_availables_on_user_id"
  end

  create_table "blazer_audits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "query_id"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at"
    t.index ["query_id"], name: "index_blazer_audits_on_query_id"
    t.index ["user_id"], name: "index_blazer_audits_on_user_id"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.bigint "creator_id"
    t.bigint "query_id"
    t.string "state"
    t.string "schedule"
    t.text "emails"
    t.text "slack_channels"
    t.string "check_type"
    t.text "message"
    t.datetime "last_run_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_checks_on_creator_id"
    t.index ["query_id"], name: "index_blazer_checks_on_query_id"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.bigint "dashboard_id"
    t.bigint "query_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_blazer_dashboard_queries_on_dashboard_id"
    t.index ["query_id"], name: "index_blazer_dashboard_queries_on_query_id"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_dashboards_on_creator_id"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.text "description"
    t.text "statement"
    t.string "data_source"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_queries_on_creator_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "payment_status"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "client_id"
    t.string "booking_type", default: "Individuel"
    t.string "status", default: "Pending"
    t.string "event"
    t.text "message"
    t.bigint "formule_id"
    t.string "cancel_type", default: "Client"
    t.string "cancellation_token"
    t.text "refusal_message"
    t.boolean "pending_slot_suggestion", default: false
    t.index ["client_id"], name: "index_bookings_on_client_id"
    t.index ["formule_id"], name: "index_bookings_on_formule_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "payment_IBAN"
    t.string "payment_BIC"
    t.string "billing_address_line1"
    t.string "billing_address_line2"
    t.string "billing_zip_code"
    t.string "billing_city"
    t.string "billing_country"
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.text "note"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_clients_on_deleted_at"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "formules", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "field"
    t.integer "duration"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address_line"
    t.string "address_city"
    t.float "latitude"
    t.float "longitude"
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.boolean "archived", default: false
    t.index ["user_id"], name: "index_formules_on_user_id"
  end

  create_table "group_clients", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_group_clients_on_client_id"
    t.index ["group_id"], name: "index_group_clients_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "endpoint"
    t.string "p256dh_key"
    t.string "auth_key"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "device_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.string "provider"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "coach"
    t.string "payment_IBAN"
    t.string "payment_BIC"
    t.string "billing_address_line1"
    t.string "billing_address_line2"
    t.string "billing_zip_code"
    t.string "billing_city", default: "Paris"
    t.string "billing_country"
    t.string "first_name"
    t.string "last_name"
    t.float "hourly_rate"
    t.string "access_token"
    t.datetime "expires_at"
    t.string "refresh_token"
    t.string "token"
    t.text "description"
    t.string "url"
    t.string "title"
    t.string "address"
    t.text "days_of_week", default: "--- [\"Monday\", \"Tuesday\", \"Wednesday\", \"Thursday\", \"Friday\"]"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "daily_start_time", default: "9:00"
    t.string "daily_end_time", default: "18:00"
    t.jsonb "excluded_fixed_weekly_slots", default: []
    t.string "phone_number"
    t.boolean "admin", default: false, null: false
    t.boolean "step_1"
    t.boolean "step_2"
    t.boolean "step_3"
    t.boolean "step_4"
    t.boolean "needs_onboarding", default: true
    t.string "twitter_username"
    t.string "instagram_username"
    t.string "tiktok_username"
    t.string "facebook_username"
    t.integer "break_time", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "availability_weeks", "users"
  add_foreign_key "availables", "users"
  add_foreign_key "bookings", "clients"
  add_foreign_key "bookings", "formules"
  add_foreign_key "bookings", "users"
  add_foreign_key "clients", "users"
  add_foreign_key "formules", "users"
  add_foreign_key "group_clients", "clients"
  add_foreign_key "group_clients", "groups"
  add_foreign_key "groups", "users"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tags", "users"
end
