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

ActiveRecord::Schema.define(version: 2020_12_19_173859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "likes", force: :cascade do |t|
    t.string "ip_address", limit: 15, null: false
    t.bigint "message_id"
    t.datetime "created_at"
    t.index ["ip_address", "message_id"], name: "index_likes_on_ip_address_and_message_id", unique: true
    t.index ["message_id"], name: "index_likes_on_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "author", limit: 50, null: false
    t.text "message", null: false
    t.integer "likes", default: 0, null: false
    t.datetime "created_at"
    t.integer "lock_version"
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["likes"], name: "index_messages_on_likes"
  end

end
