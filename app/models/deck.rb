class Deck < ActiveRecord::Base
  has_and_belongs_to_many :cards
  
  validates_presence_of :name
  validates_associated :cards
end
