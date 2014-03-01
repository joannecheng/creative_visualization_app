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

ActiveRecord::Schema.define(version: 20140127044006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignees", force: true do |t|
    t.integer "issue_id"
    t.string  "login"
  end

  create_table "issues", force: true do |t|
    t.string  "url"
    t.string  "state"
    t.string  "title"
    t.text    "body"
    t.date    "github_created_at"
    t.date    "github_closed_at"
    t.integer "github_issue_id"
    t.integer "number_comments"
    t.integer "pull_request_id"
    t.integer "repo_id"
  end

  add_index "issues", ["pull_request_id"], name: "index_issues_on_pull_request_id", using: :btree

  create_table "labels", force: true do |t|
    t.integer "issue_id"
    t.string  "name"
  end

  create_table "pull_requests", force: true do |t|
    t.string "url"
  end

  create_table "repos", force: true do |t|
    t.string "url"
  end

end
