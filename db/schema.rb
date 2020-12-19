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

ActiveRecord::Schema.define(version: 2020_12_19_125454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_slots", force: :cascade do |t|
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.bigint "booking_resource_id", null: false
    t.bigint "booking_shift_info_id", null: false
  end

  create_table "booking_closed_periods", force: :cascade do |t|
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "booking_resource_id", null: false
    t.integer "external_id"
  end

  create_table "booking_provision_types", force: :cascade do |t|
    t.bigint "location_booking_specialities_id", null: false
    t.bigint "service_id"
  end

  create_table "booking_resource_details", force: :cascade do |t|
    t.bigint "booking_resource_id", null: false
    t.integer "from_age"
    t.integer "to_age"
    t.json "schedule_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "booking_resource_prices", force: :cascade do |t|
    t.bigint "booking_resource_id", null: false
    t.decimal "price", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "booking_resources", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "location_id", null: false
    t.bigint "doctor_speciality_id", null: false
    t.bigint "provider_id", null: false
    t.bigint "doctor_service_id", null: false
    t.bigint "service_provision_type_id", null: false
    t.string "resource_code", limit: 50, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id", "resource_code"], name: "index_booking_resources_on_provider_id_and_resource_code", unique: true
  end

  create_table "booking_shift_infos", force: :cascade do |t|
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "booking_resource_id", null: false
    t.integer "duration", null: false
    t.integer "external_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "company_details", force: :cascade do |t|
    t.json "name", null: false
    t.json "official_name", default: "{}", null: false
    t.string "identification_code", limit: 20, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identification_code"], name: "index_company_details_on_identification_code"
  end

  create_table "districts", force: :cascade do |t|
    t.json "name", null: false
    t.bigint "city_id", null: false
  end

  create_table "doctor_booking_locations", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_doctor_booking_locations_on_doctor_id"
    t.index ["location_id"], name: "index_doctor_booking_locations_on_location_id"
  end

  create_table "doctor_booking_specialities", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "doctor_speciality_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_doctor_booking_specialities_on_doctor_id"
    t.index ["doctor_speciality_id"], name: "index_doctor_booking_specialities_on_doctor_speciality_id"
  end

  create_table "doctor_languages", force: :cascade do |t|
    t.integer "doctor_id", null: false
    t.integer "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctor_services", force: :cascade do |t|
    t.string "service_code", null: false
    t.integer "provider_id", null: false
    t.json "name", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id", "service_code"], name: "index_doctor_services_on_provider_id_and_service_code", unique: true, where: "(active IS TRUE)"
    t.index ["service_code"], name: "index_doctor_services_on_service_code"
  end

  create_table "doctor_specialities", force: :cascade do |t|
    t.json "name", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uniq_name", limit: 150
    t.index ["uniq_name"], name: "index_doctor_specialities_on_uniq_name", unique: true, where: "((active IS TRUE) AND (uniq_name IS NOT NULL))"
  end

  create_table "doctor_views", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.integer "views"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string "doctor_code", limit: 50, null: false
    t.integer "provider_id", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "person_id"
    t.index ["doctor_code"], name: "index_doctors_on_doctor_code"
    t.index ["person_id"], name: "index_doctors_on_person_id"
    t.index ["provider_id", "doctor_code"], name: "index_doctors_on_provider_id_and_doctor_code", unique: true, where: "(active IS TRUE)"
  end

  create_table "languages", force: :cascade do |t|
    t.json "name", null: false
  end

  create_table "location_booking_specialities", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "location_id", null: false
    t.bigint "doctor_speciality_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_location_booking_specialities_on_doctor_id"
    t.index ["doctor_speciality_id"], name: "index_location_booking_specialities_on_doctor_speciality_id"
    t.index ["location_id"], name: "index_location_booking_specialities_on_location_id"
  end

  create_table "location_types", force: :cascade do |t|
    t.json "name", null: false
    t.string "id_name", limit: 50, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "location_code", limit: 50, null: false
    t.integer "provider_id", null: false
    t.integer "location_type_id", null: false
    t.json "name", null: false
    t.json "brand_name"
    t.integer "country_id", null: false
    t.integer "city_id", null: false
    t.integer "district_id"
    t.json "address"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uniq_name", limit: 150
    t.index ["location_code"], name: "index_locations_on_location_code"
    t.index ["provider_id", "location_code"], name: "index_locations_on_provider_id_and_location_code", unique: true, where: "(active IS TRUE)"
    t.index ["uniq_name"], name: "index_locations_on_uniq_name", unique: true, where: "((active IS TRUE) AND (uniq_name IS NOT NULL))"
  end

  create_table "messages", force: :cascade do |t|
    t.string "author", limit: 50, null: false
    t.text "message", null: false
    t.integer "likes", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "persons", force: :cascade do |t|
    t.json "first_name", null: false
    t.json "last_name", null: false
    t.string "pin", limit: 50, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.index ["pin"], name: "index_persons_on_pin", unique: true, where: "(active IS TRUE)"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "image", null: false
    t.string "uuid", limit: 50, null: false
    t.bigint "category_id", null: false
    t.bigint "user_id", null: false
    t.integer "height", null: false
    t.integer "width", null: false
    t.datetime "created_at", null: false
    t.bigint "attached_to_id"
    t.decimal "hsla_color", default: [], array: true
    t.index ["attached_to_id"], name: "index_pictures_on_attached_to_id"
    t.index ["category_id"], name: "index_pictures_on_category_id"
    t.index ["user_id"], name: "index_pictures_on_user_id"
  end

  create_table "provider_settings", force: :cascade do |t|
    t.bigint "provider_id", null: false
    t.boolean "calculates_price", null: false
    t.index ["provider_id"], name: "index_provider_settings_on_provider_id"
  end

  create_table "provider_types", force: :cascade do |t|
    t.json "name", null: false
    t.string "id_name", limit: 50, null: false
  end

  create_table "providers", force: :cascade do |t|
    t.datetime "registration_date", null: false
    t.integer "provider_type_id", null: false
    t.boolean "active", default: true, null: false
    t.string "details_type"
    t.bigint "details_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["details_type", "details_id"], name: "index_providers_on_details_type_and_details_id"
  end

  create_table "service_provision_types", force: :cascade do |t|
    t.json "name", null: false
    t.string "id_name", limit: 50, null: false
    t.integer "priority", null: false
  end

  create_table "umg_confirmation_codes", force: :cascade do |t|
    t.string "confirmation_token", limit: 255, null: false
    t.string "email_code"
    t.string "sms_code"
    t.integer "retry_count", default: 0
    t.datetime "generation_time", null: false
    t.bigint "umg_user_account_id", null: false
    t.bigint "umg_confirmation_type_id"
    t.index ["confirmation_token"], name: "index_umg_confirmation_codes_on_confirmation_token"
    t.index ["umg_confirmation_type_id"], name: "index_umg_confirmation_codes_on_umg_confirmation_type_id"
    t.index ["umg_user_account_id"], name: "index_umg_confirmation_codes_on_umg_user_account_id"
  end

  create_table "umg_confirmation_types", force: :cascade do |t|
    t.string "name", limit: 150
    t.string "id_name", limit: 50
  end

  create_table "umg_user_accounts", force: :cascade do |t|
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 50, null: false
    t.date "birth_date", null: false
    t.string "phone_number", limit: 12, null: false
    t.string "email", limit: 255, null: false
    t.string "crypted_password", limit: 255, null: false
    t.boolean "active", default: false, null: false
    t.string "password_recovery_token", limit: 255
    t.integer "failed_logins_count", default: 0
    t.datetime "last_attempt_date"
    t.boolean "locked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "salt"
    t.string "personal_number", limit: 18
    t.bigint "gender_id"
    t.index ["email"], name: "index_umg_user_accounts_on_email", unique: true, where: "(active IS TRUE)"
    t.index ["gender_id"], name: "index_umg_user_accounts_on_gender_id"
    t.index ["password_recovery_token"], name: "index_umg_user_accounts_on_password_recovery_token"
    t.index ["phone_number"], name: "index_umg_user_accounts_on_phone_number", unique: true, where: "(active IS TRUE)"
  end

  create_table "user_profile_addresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profile_blood_groups", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.string "id_name", limit: 150
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profile_cities", force: :cascade do |t|
    t.json "name", null: false
    t.bigint "country_id"
    t.integer "priority", default: 0
    t.index ["country_id"], name: "index_user_profile_cities_on_country_id"
  end

  create_table "user_profile_contact_infos", force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "city_id"
    t.string "address", limit: 500
    t.bigint "umg_user_account_id"
    t.index ["city_id"], name: "index_user_profile_contact_infos_on_city_id"
    t.index ["country_id"], name: "index_user_profile_contact_infos_on_country_id"
    t.index ["umg_user_account_id"], name: "index_user_profile_contact_infos_on_umg_user_account_id", unique: true
  end

  create_table "user_profile_contact_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "user_profile_countries", force: :cascade do |t|
    t.json "name", null: false
    t.string "country_code", limit: 15
  end

  create_table "user_profile_emergency_details", force: :cascade do |t|
    t.string "full_name", limit: 50
    t.string "phone_number", limit: 12
    t.string "email", limit: 255
    t.bigint "contact_type_id"
    t.bigint "user_account_id"
    t.index ["user_account_id"], name: "index_user_profile_emergency_details_on_user_account_id", unique: true
  end

  create_table "user_profile_genders", force: :cascade do |t|
    t.string "name", limit: 10
    t.string "id_name", limit: 6
  end

  create_table "user_profile_medical_infos", force: :cascade do |t|
    t.string "allergies", limit: 500
    t.bigint "blood_group_id"
    t.bigint "umg_user_account_id", null: false
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["umg_user_account_id"], name: "index_user_profile_medical_infos_on_umg_user_account_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 50, null: false
    t.string "username", limit: 50, null: false
    t.string "password", limit: 200, null: false
    t.datetime "created_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "booking_provision_types", "location_booking_specialities", column: "location_booking_specialities_id"
  add_foreign_key "booking_provision_types", "service_provision_types", column: "service_id"
  add_foreign_key "booking_resource_details", "booking_resources"
  add_foreign_key "booking_resource_prices", "booking_resources"
  add_foreign_key "booking_resources", "doctor_services"
  add_foreign_key "booking_resources", "doctor_specialities"
  add_foreign_key "booking_resources", "doctors"
  add_foreign_key "booking_resources", "locations"
  add_foreign_key "booking_resources", "providers"
  add_foreign_key "booking_resources", "service_provision_types"
  add_foreign_key "doctor_booking_locations", "doctors"
  add_foreign_key "doctor_booking_locations", "locations"
  add_foreign_key "doctor_booking_specialities", "doctor_specialities"
  add_foreign_key "doctor_booking_specialities", "doctors"
  add_foreign_key "doctors", "persons"
  add_foreign_key "location_booking_specialities", "doctor_specialities"
  add_foreign_key "location_booking_specialities", "doctors"
  add_foreign_key "location_booking_specialities", "locations"
  add_foreign_key "locations", "user_profile_cities", column: "city_id"
  add_foreign_key "locations", "user_profile_countries", column: "country_id"
  add_foreign_key "pictures", "pictures", column: "attached_to_id"
  add_foreign_key "umg_confirmation_codes", "umg_confirmation_types"
  add_foreign_key "umg_confirmation_codes", "umg_user_accounts"
  add_foreign_key "umg_user_accounts", "user_profile_genders", column: "gender_id"
  add_foreign_key "user_profile_cities", "user_profile_countries", column: "country_id"
  add_foreign_key "user_profile_contact_infos", "umg_user_accounts"
  add_foreign_key "user_profile_contact_infos", "user_profile_cities", column: "city_id"
  add_foreign_key "user_profile_contact_infos", "user_profile_countries", column: "country_id"
  add_foreign_key "user_profile_emergency_details", "umg_user_accounts", column: "user_account_id"
  add_foreign_key "user_profile_emergency_details", "user_profile_contact_types", column: "contact_type_id"
  add_foreign_key "user_profile_medical_infos", "umg_user_accounts"
  add_foreign_key "user_profile_medical_infos", "user_profile_blood_groups", column: "blood_group_id"
end
