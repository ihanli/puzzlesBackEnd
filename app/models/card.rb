class Card < ActiveRecord::Base
  belongs_to :abstract_card
  belongs_to :user
  has_and_belongs_to_many :decks
  has_many :cards_in_game

  validates_presence_of :puzzles, :user_id, :abstract_card_id
  validates_numericality_of :puzzles, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 7
  validates_associated :user, :abstract_card
  
  delegate :target_type, :name, :loading, :path_to_img, :description, :talent, :mana, :to => :abstract_card

  def class_name
    abstract_card.unit ? abstract_card.unit.class.name : (abstract_card.spell.upgrade ? "Upgrade" : abstract_card.spell.class.name)
  end

  def attack
    abstract_card.unit.attack if abstract_card.unit
  end

  def health
    abstract_card.unit.health if abstract_card.unit
  end

  def duration
    abstract_card.spell.duration if abstract_card.spell
  end
end
