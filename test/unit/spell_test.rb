require 'test_helper'

class SpellTest < ActiveSupport::TestCase
  should validate_presence_of(:duration)
  should validate_presence_of(:abstract_card_id)

  should "validate creation of valid object" do
    assert_valid Spell.make_unsaved
  end

  should "validate range of duration" do
    assert !Spell.make_unsaved(:duration => 2.3).valid?
  end
end
