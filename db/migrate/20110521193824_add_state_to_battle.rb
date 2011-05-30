class AddStateToBattle < ActiveRecord::Migration
  def self.up
    add_column :battles, :state, :string
  end

  def self.down
    remove_column :battles, :state
  end
end
