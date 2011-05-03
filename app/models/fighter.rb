class Fighter < ActiveRecord::Base
  acts_as_state_machine :initial => :ready
  state :ready
  state :proceeding
  state :waiting
  state :finished
  
  event :proceed do
    transitions :from => :ready, :to => :proceeding
    transitions :from => :waiting, :to => :proceeding
  end

  event :wait do
    transitions :from => :ready, :to => :waiting
    transitions :from => :proceeding, :to => :waiting
  end
  
  event :finish do
    transitions :from => :waiting, :to => :finished
    transitions :from => :proceeding, :to => :finished
  end
  
  belongs_to :user
  #TODO: dependent => test me
  belongs_to :battle, :dependent => :delete
  has_one :deck
  
  validates_associated :user
  validates_associated :battle
  validates_associated :deck
  validates_numericality_of :mana, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :health, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 26
end
