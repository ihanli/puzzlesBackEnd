class Card < ActiveRecord::Base
  has_many :abstract_card
  has_one :user
  has_and_belongs_to_many :decks
end
