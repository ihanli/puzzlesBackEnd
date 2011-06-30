class Fighter < ActiveRecord::Base
  acts_as_state_machine :initial => :ready
  state :ready, :enter => :prepare_for_battle
  state :proceeding, :enter => :increase_mana
  state :waiting
  state :finished, :enter => :clean_up

  private
  @@white_list = ["proceed", "wait", "finish"]

  def increase_mana
    tmp = mana
    write_attribute(:mana, mana + 4) if battle.opened?
    mana == tmp + 4
  end

  def clean_up
    battle.destroy
  end
  
  def prepare_for_battle
    fighter.deck.cards.each do |card|
      CardInGame.create(:fighter => fighter, :card => card)
    end
    
    4.times do
      rand_card_in_game = fighter.card_in_games.first(:conditions => "state = 'ready'", :order => "RAND()")
      rand_card_in_game.draw!
    end
  end

  public

  event :proceed do
    transitions :from => :ready, :to => :proceeding
    transitions :from => :waiting, :to => :proceeding
  end

  event :wait do
    transitions :from => :ready, :to => :waiting
    transitions :from => :proceeding, :to => :waiting
  end

  event :finish do
    transitions :from => :waiting, :to => :finished
    transitions :from => :proceeding, :to => :finished
  end

  attr_accessible :mana, :health, :user_id, :battle_id, :deck

  belongs_to :user
  belongs_to :battle, :dependent => :delete
  belongs_to :deck
  has_many :card_in_games, :dependent => :delete_all

  validates_associated :user
  validates_associated :battle
  validates_associated :deck
  validates_numericality_of :mana, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :health, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 26

  def self.find_by_fbid(fb_id)
    self.includes(:user).find_by_fb_id(fb_id)
  end

  def fbid
    user.fb_id
  end

  def experience
    user.experience
  end

  def self.toggle_state(fighters, fbid)
    fighters.each do |fighter|
      tmp_state = fighter.state
      
      if fighter.fbid == fbid
        fighter.wait!
      else
        fighter.proceed!
      end
      
      tmp_state != fighter.state
    end
  end
end
