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
    decks = Deck.find_decks_by_user(user.id)
    assert_equal deck, decks.first
  end

  context "state machine event =>" do
    setup do
      subject { Deck.create(Deck.plan) }
    end

    context "use deck in fight" do
      should transition_from_through("free", "occupy")
    end

    context "free deck" do
      should transition_from_through("occupied", "free")
    end
  end
end
