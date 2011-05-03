class AddDeckIdToFighter < ActiveRecord::Migration
  def self.up
    add_column :fighters, :deck_id, :integer
  end

  def self.down
    remove_column :fighters, :deck_id
  end
end
