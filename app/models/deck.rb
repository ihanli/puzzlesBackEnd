class Deck < ActiveRecord::Base
  has_and_belongs_to_many :cards
  has_one :fighter
  
  validates_presence_of :name
  validates_associated :cards
  validates_size_of :name, :minimum => 1
  
  def self.get_decks_by_user(user_id)
    self.find(:all, :include => :cards, :conditions => ['cards.user_id = ?', user_id])
  end
end
