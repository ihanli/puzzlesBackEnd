class AddDbIndexToCards < ActiveRecord::Migration
  def self.up
    add_index :cards, :user_id
    add_index :cards, :abstract_card_id
  end

  def self.down
    remove_index :cards, :user_id
    remove_index :cards, :abstract_card_id
  end
end
