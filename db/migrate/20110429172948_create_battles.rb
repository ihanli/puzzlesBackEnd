class CreateBattles < ActiveRecord::Migration
  def self.up
    create_table :battles do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :battles
  end
end
