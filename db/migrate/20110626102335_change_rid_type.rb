class ChangeRidType < ActiveRecord::Migration
  def self.up
    change_column :battles, :rid, :string
  end

  def self.down
    change_column :battles, :rid, :integer
  end
end
