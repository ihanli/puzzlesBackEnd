class AddDbIndexToSpells < ActiveRecord::Migration
  def self.up
    add_index :spells, :abstract_card_id
  end

  def self.down
    remove_index :spells, :abstract_card_id
  end
end
