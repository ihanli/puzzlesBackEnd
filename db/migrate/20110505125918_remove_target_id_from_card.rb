class RemoveTargetIdFromCard < ActiveRecord::Migration
  def self.up
    remove_column :cards, :target_id
  end

  def self.down
    add_column :cards, :target_id, :string
  end
end
