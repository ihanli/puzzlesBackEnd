class ChangeExperienceDefault < ActiveRecord::Migration
  def self.up
    change_column_default :users, :experience, 0
  end

  def self.down
    change_column :users, :experience, :integer
  end
end
