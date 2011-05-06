class CreateCardInGames < ActiveRecord::Migration
  def self.up
    create_table :card_in_games do |t|
      t.integer :fighter_id
      t.integer :card_id
      t.string :state
      
      t.timestamps
    end
  end

  def self.down
    drop_table :card_in_games
  end
end
