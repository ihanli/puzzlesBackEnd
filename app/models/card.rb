class Card < ActiveRecord::Base
  belongs_to :abstract_card
  has_one :user
  has_and_belongs_to_many :decks
  has_many :cards_in_game
  
  validates_presence_of :puzzles, :user_id, :abstract_card_id
  validates_numericality_of :puzzles, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 7
  validates_associated :user, :abstract_card
  
  def self.get_cards_by_user(user_id)
    self.find(:all, :conditions => ['user_id = ?', user_id])
  end
end
