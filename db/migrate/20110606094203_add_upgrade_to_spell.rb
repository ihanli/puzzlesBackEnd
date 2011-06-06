class AddUpgradeToSpell < ActiveRecord::Migration
  def self.up
    add_column :spells, :upgrade, :boolean, :default => false
  end

  def self.down
    remove_column :spells, :upgrade
  end
end
