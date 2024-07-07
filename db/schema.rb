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

ActiveRecord::Schema[7.0].define(version: 2024_07_07_070731) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.bigint "owner_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_campaigns_on_owner_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "note_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["note_id"], name: "index_comments_on_note_id"
  end

  create_table "counters", force: :cascade do |t|
    t.text "label"
    t.integer "count", default: 0
    t.bigint "note_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_counters_on_note_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sender_id", null: false
    t.bigint "recipient_id", null: false
    t.bigint "campaign_id", null: false
    t.index ["campaign_id", "recipient_id"], name: "index_invitations_on_campaign_id_and_recipient_id", unique: true
    t.index ["campaign_id"], name: "index_invitations_on_campaign_id"
    t.index ["recipient_id"], name: "index_invitations_on_recipient_id"
    t.index ["sender_id"], name: "index_invitations_on_sender_id"
  end

  create_table "journals", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_journals_on_author_id"
  end

  create_table "membership_journals", force: :cascade do |t|
    t.bigint "membership_id", null: false
    t.bigint "journal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journal_id"], name: "index_membership_journals_on_journal_id"
    t.index ["membership_id", "journal_id"], name: "index_membership_journals_on_membership_id_and_journal_id", unique: true
    t.index ["membership_id"], name: "index_membership_journals_on_membership_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", null: false
    t.bigint "campaign_id", null: false
    t.index ["campaign_id"], name: "index_memberships_on_campaign_id"
    t.index ["member_id"], name: "index_memberships_on_member_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "journal_id", null: false
    t.string "name", default: "", null: false
    t.bigint "author_id", null: false
    t.integer "comments_count", default: 0
    t.index ["author_id"], name: "index_notes_on_author_id"
    t.index ["journal_id"], name: "index_notes_on_journal_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.string "bio", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "campaigns", "users", column: "owner_id"
  add_foreign_key "comments", "notes"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "counters", "notes"
  add_foreign_key "invitations", "campaigns"
  add_foreign_key "invitations", "users", column: "recipient_id"
  add_foreign_key "invitations", "users", column: "sender_id"
  add_foreign_key "journals", "users", column: "author_id"
  add_foreign_key "membership_journals", "journals"
  add_foreign_key "membership_journals", "memberships"
  add_foreign_key "memberships", "campaigns"
  add_foreign_key "memberships", "users", column: "member_id"
  add_foreign_key "notes", "journals"
  add_foreign_key "notes", "users", column: "author_id"
end
