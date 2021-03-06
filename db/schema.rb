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

ActiveRecord::Schema.define(version: 2019_12_11_103524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.text "text"
    t.integer "likes"
    t.integer "commentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.string "followable_type", null: false
    t.bigint "followable_id", null: false
    t.string "follower_type", null: false
    t.bigint "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable_type_and_followable_id"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
    t.index ["follower_type", "follower_id"], name: "index_follows_on_follower_type_and_follower_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "date"
    t.bigint "vTeam_id"
    t.bigint "hTeam_id"
    t.integer "hTeamScore"
    t.integer "vTeamScore"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vteam_q1"
    t.integer "vteam_q2"
    t.integer "vteam_q3"
    t.integer "vteam_q4"
    t.integer "hteam_q1"
    t.integer "hteam_q2"
    t.integer "hteam_q3"
    t.integer "hteam_q4"
    t.date "date_time"
    t.index ["hTeam_id"], name: "index_games_on_hTeam_id"
    t.index ["vTeam_id"], name: "index_games_on_vTeam_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "jersey_number"
    t.string "position"
    t.string "height"
    t.bigint "team_id"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "player_id"
    t.index ["team_id"], name: "index_people_on_team_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "category"
    t.string "photo"
    t.boolean "user_generated"
    t.text "content"
    t.integer "likes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "people_id"
    t.bigint "team_id"
    t.index ["people_id"], name: "index_posts_on_people_id"
    t.index ["team_id"], name: "index_posts_on_team_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.string "city"
    t.string "state"
    t.string "abbrevation"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_team_id"
    t.integer "wins"
    t.integer "losses"
    t.string "conference"
    t.integer "standing"
    t.float "win_percent"
    t.float "games_behind"
    t.integer "conf_win"
    t.integer "last10wins"
    t.integer "last10loss"
    t.integer "streak"
    t.boolean "streak_wins"
    t.integer "conf_loss"
  end

  create_table "tweets", force: :cascade do |t|
    t.text "text"
    t.string "name"
    t.string "handle"
    t.integer "followers"
    t.string "avatar"
    t.date "posted_at"
    t.string "url"
    t.string "image"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.boolean "called"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "videoid"
    t.string "description"
    t.string "thumbnail"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "comments", "users"
  add_foreign_key "games", "teams", column: "hTeam_id"
  add_foreign_key "games", "teams", column: "vTeam_id"
  add_foreign_key "people", "teams"
  add_foreign_key "posts", "people", column: "people_id"
  add_foreign_key "posts", "teams"
  add_foreign_key "posts", "users"
  add_foreign_key "tweets", "users"
  add_foreign_key "videos", "users"
end
