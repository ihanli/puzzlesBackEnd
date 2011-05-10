require 'test_helper'

class CardTest < ActiveSupport::TestCase
	should validate_presence_of(:puzzles)
	should validate_presence_of(:user_id)
	should validate_presence_of(:abstract_card_id)
	
	should "validate puzzle range" do
		assert_valid Card.make_unsaved
		assert !Card.make_unsaved(:puzzles => 7).valid?
		assert !Card.make_unsaved(:puzzles => -1).valid?
	end
	
  should "validate object after creation" do
    test_card = Card.create(Card.plan)
    assert_valid test_card
  end
  
  should "get cards by user" do
    card = Card.create(Card.plan)
    user = User.create(User.plan)
    cards = Card.get_cards_by_user(user.id)
    assert_equal card, cards.first
  end
end
