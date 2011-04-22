require 'test_helper'

class DeckTest < ActiveSupport::TestCase

	should validate_presence_of(:name)
	
	should "validate name length" do
		assert_valid Deck.make_unsaved
		assert !Deck.make_unsaved(:name => "").valid?
	end
end
