class CreateCardDeckJoinTable < ActiveRecord::Migration
  def self.up
    create_table :cards_decks, :id => false do |t|
      t.integer :card_id
      t.integer :deck_id
    end
  end

  def self.down
    drop_table :cards_decks
  end
end
