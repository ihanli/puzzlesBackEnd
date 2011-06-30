require 'test_helper'

class FighterTest < ActiveSupport::TestCase
  should "validate creation of valid object" do
    assert_valid Fighter.make_unsaved
  end

  should "validate lower bound of mana" do
    assert !Fighter.make_unsaved(:mana => -1).valid?
  end

  should "validate health range" do
    assert !Fighter.make_unsaved(:health => -1).valid?
    assert !Fighter.make_unsaved(:health => 26).valid?
  end
  
  should "validate object and state after creation" do
    test_fighter = Fighter.create(Fighter.plan)
    assert test_fighter.ready?
  end
  
  should "recover mana" do
    test_fighter_one = Fighter.create(Fighter.plan)
    test_deck = Deck.create(Deck.plan)
    test_deck.cards << Card.create(Card.plan)
    test_deck.cards.first.abstract_card = AbstractCard.create(AbstractCard.plan)
    test_deck.fighter = test_fighter_one
    test_battle = Battle.create(Battle.plan)
    test_fighter_one.battle = test_battle
    test_battle.start!
    test_fighter_one.proceed!
    assert_equal 9, test_fighter_one.mana
  end

  context "state machine event =>" do
    setup do
      subject { Fighter.create(Fighter.plan) }
      Fighter.create(Fighter.plan)
      subject.battle = Battle.create(Battle.plan)
    end

    context "proceeds at beginning" do
      should transition_from_through("ready", "proceed")
    end

    context "proceeds after turn of opponent ended" do
      should transition_from_through("waiting", "proceed")
    end

    context "waits for his turn after start" do
      should transition_from_through("ready", "wait")
    end

    context "waits after his turn ended" do
      should transition_from_through("proceeding", "wait")
    end

    context "can quit battle while waiting" do
      should transition_from_through("waiting", "finish")
    end

    context "can quit battle during his turn" do
      should transition_from_through("proceeding", "finish")
    end
  end
end
