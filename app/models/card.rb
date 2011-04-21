class Card < ActiveRecord::Base
  has_many :abstract_card
  has_one :user
  has_and_belongs_to_many :decks
  
  validates_presence_of :puzzles, :user_id, :abstract_card_id
  validates_numericality_of :puzzles, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 7
  validates_associated :user, :abstract_card 
  
end
