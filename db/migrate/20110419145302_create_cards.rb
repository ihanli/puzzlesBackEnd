class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.integer :puzzles
      t.integer :user_id
      t.integer :abstract_card_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :cards
  end
end
