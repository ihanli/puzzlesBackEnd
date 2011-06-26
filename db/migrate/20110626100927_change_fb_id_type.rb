class ChangeFbIdType < ActiveRecord::Migration
  def self.up
    change_column :users, :fb_id, :string
  end

  def self.down
    change_column :users, :fb_id, :integer
  end
end
