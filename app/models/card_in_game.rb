class CardInGame < ActiveRecord::Base
  acts_as_state_machine :initial => :removed
  state :ready
  state :drawn
  state :summoned
  state :inactive
  state :casted
  state :attacking
  state :destroyed
  state :removed

  private
  @@white_list = ["get_ready", "draw", "summon", "activate", "deactive", "place_unit", "cast", "attack", "destroy", "remove"]
  public

  event :get_ready do
    transitions :from => :removed, :to => :ready
    transitions :from => :destroyed, :to => :ready
  end

  event :draw do
    transitions :from => :ready, :to => :drawn
    transitions :from => :destroyed, :to => :drawn
    transitions :from => :casted, :to => :drawn
    transitions :from => :summoned, :to => :drawn
    transitions :from => :inactive, :to => :drawn
  end

  event :summon do
    transitions :from => :ready, :to => :summoned
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
    transitions :from => :ready, :to => :casted
    transitions :from => :drawn, :to => :casted
    transitions :from => :destroyed, :to => :casted
  end

  event :attack do
    transitions :from => :summoned, :to => :attacking
  end

  event :destroy do
    transitions :from => :ready, :to => :destroyed
    transitions :from => :drawn, :to => :destroyed
    transitions :from => :summoned, :to => :destroyed
    transitions :from => :casted, :to => :destroyed
    transitions :from => :attacking, :to => :destroyed
  end

  event :remove do
    transitions :from => :ready, :to => :removed
    transitions :from => :drawn, :to => :removed
    transitions :from => :inactive, :to => :removed
    transitions :from => :summoned, :to => :removed
    transitions :from => :casted, :to => :removed
    transitions :from => :attacking, :to => :removed
    transitions :from => :destroyed, :to => :removed
  end

  belongs_to :fighter
  belongs_to :card
  has_one :card_in_game, :foreign_key => "target_id"

  validates_presence_of :fighter_id, :card_id
  validates_associated :fighter, :card

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

#  TODO: remove tests for attack and health
#  def attack
#    card.attack
#  end
#
#  def health
#    card.health
#  end

  def duration
    card.duration
  end

  def transition_to(event)
    @@white_list.each do |s|
      if s == event
        tmp_state = state
        send("#{event}!")
        return true if tmp_state != state
      end
    end
    false
  end
end