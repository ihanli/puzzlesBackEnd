class AbstractCard < ActiveRecord::Base
  has_one :unit, :dependent => :destroy
  has_one :spell, :dependent => :destroy
  has_many :cards
end
