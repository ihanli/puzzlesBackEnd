class AbstractCard < ActiveRecord::Base
  has_one :unit, :dependent => :delete
  has_one :spell, :dependent => :delete
  belongs_to :cards
end
