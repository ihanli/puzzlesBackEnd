class CreateSpells < ActiveRecord::Migration
  def self.up
    create_table :spells do |t|
      t.integer :duration
      t.integer :abstract_card_id

      t.timestamps
    end
  end

  def self.down
    drop_table :spells
  end
end
