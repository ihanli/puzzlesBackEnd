class User < ActiveRecord::Base
  has_many :cards
end
