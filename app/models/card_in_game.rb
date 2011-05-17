class CardInGame < ActiveRecord::Base
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

  belongs_to :fighter
  belongs_to :card
  has_one :card_in_game, :foreign_key => "target_id"

  validates_presence_of :fighter_id, :card_id
  validates_associated :fighter, :card

  #TODO: test me from here
  def class_name
    card.class_name
  end

  def target_type
    card.target_type
  end

  def name
    card.name
  end

  def loading
    card.loading
  end

  def path_to_img
    card.path_to_img
  end

  def description
    card.description
  end

  def talent
    card.talent
  end

  def mana
    card.mana
  end

  def attack
    card.attack
  end

  def health
    card.health
  end

  def duration
    card.duration
  end

  def transition_to(event)
    tmp_state = card.state

    case event
    when "get_ready"
      card.get_ready!
    when "draw"
      card.draw!
    when "summon"
      card.summon!
    when "deactivate"
      card.deactivate!
    when "cast"
      card.cast!
    when "attack"
      card.attack!
    when "destroy"
      card.destroy!
    when "remove_from_game"
      card.remove_from_game!
    end

    return true if tmp_state != card.state
    false
  end
end