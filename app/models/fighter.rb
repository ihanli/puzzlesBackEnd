class Fighter < ActiveRecord::Base
  acts_as_state_machine :initial => :ready
  state :ready
  state :proceeding
  state :waiting
  state :finished

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

  belongs_to :user
  #TODO: dependent => test me
  belongs_to :battle, :dependent => :delete
  belongs_to :deck
  has_many :card_in_games, :dependent => :delete_all

  validates_associated :user
  validates_associated :battle
  validates_associated :deck
  validates_numericality_of :mana, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :health, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 26

  def self.get_fighters_by_battle(battle_id)
    self.find(:all, :conditions => ['battle_id = ?', battle_id])
  end

  def fbid
    user.fb_id
  end

  def experience
    user.experience
  end

  def transition_to(event)
    self.each do |fighter|
      tmp_state = fighter.state

      case event
      when "proceed" || "wait"
      #TODO: give id of logged in user as parameter
      if fighter.fbid == params[:user_id]
        fighter.wait!
      else
        fighter.proceed!
      end
      when "finish"
        fighter.finish!
      end

      return false unless tmp_state != fighter.state
    end

    true
  end
end
