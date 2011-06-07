class Deck < ActiveRecord::Base
  acts_as_state_machine :initial => :free
  state :free
  state :occupied

  event :occupy do
    transitions :from => :free, :to => :occupied
  end

  event :free do
    transitions :from => :occupied, :to => :free
  end

  has_and_belongs_to_many :cards
  has_one :fighter

  validates_presence_of :name
  validates_associated :cards
  validates_size_of :name, :minimum => 1

  def self.find_decks_by_user(user_id)
    self.find(:all, :include => :cards, :conditions => ['cards.user_id = ?', user_id])
  end

  def change_state
    tmp_state = self.state

    unless self.cards.first.card_in_games
      self.free!
    else
      self.occupy!
    end

    tmp_state != deck.state
  end
end
