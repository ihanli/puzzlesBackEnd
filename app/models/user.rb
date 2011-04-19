class User < ActiveRecord::Base
  has_many :cards, :dependent => :delete_all
end
