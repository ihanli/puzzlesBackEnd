class Spell < ActiveRecord::Base
  belongs_to :abstract_card, :dependent => :delete
  
  validates_presence_of :abstract_card_id, :duration
  validates_numericality_of :duration, :only_integer => true, :minimum => -1
end
