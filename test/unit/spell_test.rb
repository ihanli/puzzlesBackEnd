require 'test_helper'

class SpellTest < ActiveSupport::TestCase
  should validate_presence_of(:duration)
  should validate_presence_of(:abstract_card_id)
  
  should "validate range of duration" do
    assert_valid Spell.make_unsaved
    assert !Spell.make_unsaved(:duration => 2.3).valid?
  end
end
