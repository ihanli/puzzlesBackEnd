class Battle < ActiveRecord::Base
  acts_as_state_machine :initial => :pending
  state :pending
  state :opened, :enter => :copy_decks
  state :drawing
  state :placing
  state :attacking
  state :finished, :enter => :clean_up

  private
  def clean_up
    destroy
  end

  def copy_decks
    fighters.each do |fighter|
      fighter.deck.cards.each do |card|
        card_copy = CardInGame.create(card)
        card_copy.card_in_game = card_copy if card.talent.include?("self") or card.talent.include?("own")
      end
    end
  end

  public
  event :start do
    transitions :from => :pending, :to => :opened
  end

  event :draw do
    transitions :from => :opened, :to => :drawing
    transitions :from => :attacking, :to => :drawing
    transitions :from => :placing, :to => :drawing
  end

  event :place do
    transitions :from => :opened, :to => :placing
    transitions :from => :drawing, :to => :placing
  end

  event :attack do
    transitions :from => :drawing, :to => :attacking
    transitions :from => :placing, :to => :attacking
  end

  event :finish do
    transitions :from => :opened, :to => :finished
    transitions :from => :drawing, :to => :finished
    transitions :from => :placing, :to => :finished
    transitions :from => :attacking, :to => :finished
  end

  has_many :fighters, :dependent => :delete_all
  has_many :users, :through => :fighters

  def self.get_battles_by_user(fb_id)
    self.find(:all, :include => :users, :conditions => ['users.fb_id = ?', fb_id])
  end
end
