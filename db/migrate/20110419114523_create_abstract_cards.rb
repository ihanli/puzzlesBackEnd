class CreateAbstractCards < ActiveRecord::Migration
  def self.up
    create_table :abstract_cards do |t|
      t.string :description
      t.string :path_to_img
      t.string :name
      t.string :talent
      t.integer :mana
      t.integer :loading

      t.timestamps
    end
  end

  def self.down
    drop_table :abstract_cards
  end
end
