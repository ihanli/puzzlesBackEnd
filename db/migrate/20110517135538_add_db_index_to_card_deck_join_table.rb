class AddDbIndexToCardDeckJoinTable < ActiveRecord::Migration
  def self.up
    add_index :cards_decks, :card_id
    add_index :cards_decks, :deck_id
  end

  def self.down
    remove_index :cards_decks, :card_id
    remove_index :cards_decks, :deck_id
  end
end
