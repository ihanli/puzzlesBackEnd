class AddStateToDeck < ActiveRecord::Migration
  def self.up
    add_column :decks, :state, :string
  end

  def self.down
    remove_column :decks, :state
  end
end
