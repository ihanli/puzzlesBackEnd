class AbstractCard < ActiveRecord::Base
  has_one :unit, :dependent => :delete
  has_one :spell, :dependent => :delete
  has_many :cards
  
  validates_presence_of :name, :description, :path_to_img, :mana, :loading
  validates_uniqueness_of :name
  validates_size_of :description, :within => 1..140
  validates_size_of :path_to_img, :minimum => 5
  validates_numericality_of :mana, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :loading, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 6
  validates_format_of :path_to_img, :with => /^.+\.((jpg)|(gif)|(jpeg)|(png))$/
    
  #TODO: validation for talent semantic
end
