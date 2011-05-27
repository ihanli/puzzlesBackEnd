require 'test_helper'

class DeckTest < ActiveSupport::TestCase

	should validate_presence_of(:name)
	
	should "validate name length" do
		assert_valid Deck.make_unsaved
		assert !Deck.make_unsaved(:name => "").valid?
	end
	
  should "get decks by user" do
    deck = Deck.create(Deck.plan)
    Card.create(Card.plan)
    deck.cards = Card.find(:all)
    user = User.create(User.plan)
    decks = Deck.get_decks_by_user(user.id)
    assert_equal deck, decks.first
  end
end
