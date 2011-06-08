class AddRidToBattle < ActiveRecord::Migration
  def self.up
    add_column :battles, :rid, :integer
  end

  def self.down
    remove_column :battles, :rid
  end
end
