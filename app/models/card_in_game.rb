class CardInGame < ActiveRecord::Base
  acts_as_state_machine :initial => :ready
  state :ready
  state :drawn
  state :summoned
  state :inactive
  state :casted
  state :attacking
  state :destroyed
  state :removed, :enter => :clean_up

  private
  @@white_list = ["get_ready", "draw", "summon", "activate", "deactive", "place_unit", "cast", "attack", "destroy", "remove"]
  @@talent_list = ["attack", "health", "summon", "destroy", "deactivate"]

  def clean_up
    destroy
  end

  def use_talent
    target_card = CardInGame.find_by_id(target_id)

    @@talent_list.each do |word|
      if talent.include?(word)
        if word == @@talent_list[0] or word == @@talent_list[1]
          target_card.update_attributes(word.to_sym => target_card.send(word) + talent[/[-+]{1}[1-9]/].to_i)
        else
          target_card.send(word + "!")
        end
      end
    end
  end

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
    transitions :from => :inactive, :to => :destroyed
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
  
  delegate :target_type, :name,:loading, :path_to_img, :description, :talent, :mana, :to => :abstract_card
  delegate :class_name, :duration, :to => :card

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