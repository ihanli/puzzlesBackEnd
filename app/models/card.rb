class Card < ActiveRecord::Base
  acts_as_state_machine :initial => :off_game
  state :ready_to_play
  state :drawn
  state :summoned
  state :inactive
  state :casted
  state :attacking
  state :destroyed
  state :off_game
  
  event :get_ready do
    transitions :from => :off_game, :to => :ready_to_play
    transitions :from => :destroyed, :to => :ready_to_play    
  end
  
  event :draw do
    transitions :from => :ready_to_play, :to => :drawn
    transitions :from => :destroyed, :to => :drawn
    transitions :from => :casted, :to => :drawn
    transitions :from => :summoned, :to => :drawn
    transitions :from => :inactive, :to => :drawn
  end
  
  event :summon do
    transitions :from => :ready_to_play, :to => :summoned
    transitions :from => :drawn, :to => :summoned
    transitions :from => :destroyed, :to => :summoned
  end
  
  event :activate do
    transitions :from => :inactive, :to => :summoned
  end
  
  event :deactivate do
    transitions :from => :summoned, :to => :inactive
  end
  
  event :place_unit do
    transitions :from => :drawn, :to => :inactive
  end
  
  event :cast do
    transitions :from => :ready_to_play, :to => :casted
    transitions :from => :drawn, :to => :casted
    transitions :from => :destroyed, :to => :casted
  end
  
  event :attack do
    transitions :from => :summoned, :to => :attacking
  end
  
  event :destroy do
    transitions :from => :ready_to_play, :to => :destroyed
    transitions :from => :drawn, :to => :destroyed
    transitions :from => :summoned, :to => :destroyed
    transitions :from => :casted, :to => :destroyed
    transitions :from => :attacking, :to => :destroyed
  end
  
  event :remove_from_game do
    transitions :from => :ready_to_play, :to => :off_game
    transitions :from => :drawn, :to => :off_game
    transitions :from => :inactive, :to => :off_game
    transitions :from => :summoned, :to => :off_game
    transitions :from => :casted, :to => :off_game
    transitions :from => :attacking, :to => :off_game
    transitions :from => :destroyed, :to => :off_game
  end
  
  belongs_to :abstract_card
  has_one :user
  has_and_belongs_to_many :decks
  
  validates_presence_of :puzzles, :user_id, :abstract_card_id
  validates_numericality_of :puzzles, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 7
  validates_associated :user, :abstract_card
  
  def self.get_cards_by_user(user_id)
    self.find(:all, :conditions => ['user_id = ?', user_id])
  end
end
