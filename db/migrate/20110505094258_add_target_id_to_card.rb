class AddTargetIdToCard < ActiveRecord::Migration
  def self.up
    add_column :cards, :target_id, :integer
  end

  def self.down
    remove_column :cards, :target_id
  end
end
