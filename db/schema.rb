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

ActiveRecord::Schema.define(:version => 20110506093517) do

  create_table "abstract_cards", :force => true do |t|
    t.string   "description"
    t.string   "path_to_img"
    t.string   "name"
    t.string   "talent"
    t.integer  "mana"
    t.integer  "loading"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "battles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "card_in_games", :force => true do |t|
    t.integer  "fighter_id"
    t.integer  "card_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "target_id"
  end

  create_table "cards", :force => true do |t|
    t.integer  "puzzles"
    t.integer  "user_id"
    t.integer  "abstract_card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards_decks", :id => false, :force => true do |t|
    t.integer "card_id"
    t.integer "deck_id"
  end

  create_table "decks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "fighters", :force => true do |t|
    t.integer  "battle_id"
    t.integer  "user_id"
    t.integer  "mana",       :default => 5
    t.integer  "health",     :default => 25
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deck_id"
  end

  create_table "spells", :force => true do |t|
    t.integer  "duration"
    t.integer  "abstract_card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "units", :force => true do |t|
    t.integer  "attack"
    t.integer  "health"
    t.integer  "abstract_card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "fb_id"
    t.integer  "experience"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
