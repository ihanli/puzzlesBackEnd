class AddTargetTypeToAbstractCard < ActiveRecord::Migration
  def self.up
    add_column :abstract_cards, :target_type, :string
  end

  def self.down
    remove_column :abstract_cards, :target_type
  end
end
