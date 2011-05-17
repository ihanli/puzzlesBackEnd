class AddDbIndexToUnits < ActiveRecord::Migration
  def self.up
    add_index :units, :abstract_card_id
  end

  def self.down
    remove_index :units, :abstract_card_id
  end
end
