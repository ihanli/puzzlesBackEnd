class Unit < ActiveRecord::Base
  belongs_to :abstract_card, :dependent => :delete
  
  validates_presence_of :attack, :health, :abstract_card_id
  validates_numericality_of :attack, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :health, :only_integer => true, :greater_than_or_equal_to => 0
end
