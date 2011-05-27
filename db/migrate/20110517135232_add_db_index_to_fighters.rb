class AddDbIndexToFighters < ActiveRecord::Migration
  def self.up
    add_index :fighters, :battle_id
    add_index :fighters, :user_id
    add_index :fighters, :deck_id
  end

  def self.down
    remove_index :fighters, :battle_id
    remove_index :fighters, :user_id
    remove_index :fighters, :deck_id
  end
end
