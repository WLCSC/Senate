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

ActiveRecord::Schema.define(:version => 20110809171422) do

  create_table "announcements", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chamber_id"
  end

  create_table "ballot_remarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ballot_id"
    t.integer  "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ballots", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.text     "options"
    t.boolean  "closed"
    t.integer  "creator_id"
    t.integer  "chamber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "anonymous"
  end

  create_table "boards", :force => true do |t|
    t.string   "name"
    t.text     "about"
    t.integer  "chamber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chambers", :force => true do |t|
    t.string   "name"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.string   "ancestry"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "about"
    t.string   "auth_attribute"
    t.string   "auth_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "news_items", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "priority"
    t.boolean  "readable"
    t.boolean  "commentable"
    t.boolean  "proposable"
    t.boolean  "remarkable"
    t.boolean  "votable"
    t.integer  "chamber_id"
    t.integer  "principal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "administratable"
  end

  create_table "principals", :force => true do |t|
    t.string   "securable_type"
    t.integer  "securable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposal_remarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.integer  "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "creator_id"
    t.integer  "chamber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "closed"
  end

  create_table "titles", :force => true do |t|
    t.string   "text"
    t.text     "about"
    t.integer  "chamber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "titles_users", :id => false, :force => true do |t|
    t.integer "title_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.boolean  "administrator"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "email"
  end

end
