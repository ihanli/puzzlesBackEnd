class AddStateToCard < ActiveRecord::Migration
  def self.up
    add_column :cards, :state, :string
  end

  def self.down
    remove_column :cards, :state
  end
end
