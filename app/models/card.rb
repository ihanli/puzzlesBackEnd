class Card < ActiveRecord::Base
  belongs_to :abstract_card
  belongs_to :user
  has_and_belongs_to_many :decks
  has_many :cards_in_game

  validates_presence_of :puzzles, :user_id, :abstract_card_id
  validates_numericality_of :puzzles, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 7
  validates_associated :user, :abstract_card

  def self.get_cards_by_user(user_id)
    self.find_all_by_user_id(user_id)
  end

  #TODO: test me from here
  def class_name
    abstract_card.unit ? abstract_card.unit.class.name : (abstract_card.spell.upgrade ? "Upgrade" : abstract_card.spell.class.name)
  end

  def target_type
    abstract_card.target_type
  end

  def name
    abstract_card.name
  end

  def loading
    abstract_card.loading
  end

  def path_to_img
    abstract_card.path_to_img
  end

  def description
    abstract_card.description
  end

  def talent
    abstract_card.talent
  end

  def mana
    abstract_card.mana
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
