class CreateFighters < ActiveRecord::Migration
  def self.up
    create_table :fighters do |t|
      t.integer :battle_id
      t.integer :user_id
      t.integer :mana, :default => 5
      t.integer :health, :default => 25
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :fighters
  end
end
