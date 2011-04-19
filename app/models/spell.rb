class Spell < ActiveRecord::Base
  belongs_to :abstract_card, :dependent => :destroy
end
