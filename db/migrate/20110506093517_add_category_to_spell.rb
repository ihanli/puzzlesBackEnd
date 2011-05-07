class AddCategoryToSpell < ActiveRecord::Migration
  def self.up
    add_column :spells, :category, :string
  end

  def self.down
    remove_column :spells, :category
  end
end
