class User < ActiveRecord::Base
  has_many :cards, :dependent => :delete_all
  #TODO: dependent => test me
  has_many :fighters, :dependent => :delete_all
  has_many :battles, :through => :fighters

  validates_presence_of :fb_id, :experience
  validates_numericality_of :fb_id, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :experience, :only_integer => true, :greater_than_or_equal_to => 0
end