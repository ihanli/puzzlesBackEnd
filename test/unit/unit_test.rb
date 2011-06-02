require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  should validate_presence_of(:abstract_card_id)
  should validate_presence_of(:health)
  should validate_presence_of(:attack)

  should "validate creation of valid object" do
    assert_valid Unit.make_unsaved
  end

  should "validate min value of health" do
    assert !Unit.make_unsaved(:health => -1).valid?
  end

  should "validate min value of attack" do
    assert !Unit.make_unsaved(:attack => -1).valid?
  end
end
