require 'test_helper'

class CardTest < ActiveSupport::TestCase
	should validate_presence_of(:puzzles)
	should validate_presence_of(:user_id)
	should validate_presence_of(:abstract_card_id)
	
	should "validate puzzle range" do
		assert_valid Card.make_unsaved()
		assert !Card.make_unsaved(:puzzles => 7).valid?
		assert !Card.make_unsaved(:puzzles => -1).valid?
	end
	
	
	
end
