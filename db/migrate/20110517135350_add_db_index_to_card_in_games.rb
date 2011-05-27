class AddDbIndexToCardInGames < ActiveRecord::Migration
  def self.up
    add_index :card_in_games, :fighter_id
    add_index :card_in_games, :card_id
    add_index :card_in_games, :target_id
  end

  def self.down
    remove_index :card_in_games, :fighter_id
    remove_index :card_in_games, :card_id
    remove_index :card_in_games, :target_id
  end
end
