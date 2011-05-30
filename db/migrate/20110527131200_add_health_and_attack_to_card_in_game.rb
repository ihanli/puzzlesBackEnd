class AddHealthAndAttackToCardInGame < ActiveRecord::Migration
  def self.up
    add_column :card_in_games, :attack, :integer
    add_column :card_in_games, :health, :integer
  end

  def self.down
    remove_column :card_in_games, :health
    remove_column :card_in_games, :attack
  end
end
