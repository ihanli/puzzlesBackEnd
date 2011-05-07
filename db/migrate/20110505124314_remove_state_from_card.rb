class RemoveStateFromCard < ActiveRecord::Migration
  def self.up
    remove_column :cards, :state
  end

  def self.down
    add_column :cards, :state, :string
  end
end
