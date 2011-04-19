class Unit < ActiveRecord::Base
  belongs_to :abstract_card, :dependent => :delete
end
