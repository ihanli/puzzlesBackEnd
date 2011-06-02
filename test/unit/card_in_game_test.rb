require 'test_helper'

class CardInGameTest < ActiveSupport::TestCase
  should "validate object and state after creation" do
    test_card_in_game = CardInGame.create(CardInGame.plan)
    assert_valid test_card_in_game
    assert test_card_in_game.removed?
  end

  context "state machine event =>" do
    setup do
      subject { CardInGame.create(CardInGame.plan) }
    end

    context "bring card into game" do
      should transition_from_through("removed", "get_ready")
    end

    context "draw card from deck" do
      should transition_from_through("ready", "draw")
    end

    context "take summoned card back" do
      should transition_from_through("summoned", "draw")
    end
    
    context "take destroyed card back" do
      should transition_from_through("destroyed", "draw")
    end

    context "take casted card back" do
      should transition_from_through("casted", "draw")
    end

    context "take back inactive card" do
      should transition_from_through("inactive", "draw")
    end

    context "deactivate summoned unit" do
      should transition_from_through("summoned", "deactivate")
    end

    context "place unit on field" do
      should transition_from_through("drawn", "place_unit")
    end

    context "summon unit from deck" do
      should transition_from_through("ready", "summon")
    end

    context "summon unit instantly" do
      should transition_from_through("drawn", "summon")
    end

    context "summon destroyed unit" do
      should transition_from_through("destroyed", "summon")
    end

    context "activate inactive unit" do
      should transition_from_through("inactive", "activate")
    end

    context "cast spell from deck" do
      should transition_from_through("ready", "cast")
    end

    context "cast drawn spell" do
      should transition_from_through("drawn", "cast")
    end

    context "cast spell from cemetery" do
      should transition_from_through("destroyed", "cast")
    end

    context "attack after activation" do
      should transition_from_through("summoned", "attack")
    end

    context "bring card back from cemetery" do
      should transition_from_through("destroyed", "get_ready")
    end

    context "destroy card from deck" do
      should transition_from_through("ready", "destroy")
    end

    context "destroy drawn card" do
      should transition_from_through("drawn", "destroy")
    end

    context "destroy summoned unit" do
      should transition_from_through("summoned", "destroy")
    end

    context "destroy casted spell" do
      should transition_from_through("casted", "destroy")
    end

    context "destroy attacking unit" do
      should transition_from_through("attacking", "destroy")
    end

    context "take card from deck out of game" do
      should transition_from_through("ready", "remove")
    end

    context "take drawn card out of game" do
      should transition_from_through("drawn", "remove")
    end

    context "take summoned unit out of game" do
      should transition_from_through("summoned", "remove")
    end

    context "take inactive unit out of game" do
      should transition_from_through("inactive", "remove")
    end

    context "take casted spell out of game" do
      should transition_from_through("casted", "remove")
    end

    context "take attacking unit out of game" do
      should transition_from_through("attacking", "remove")
    end

    context "take card from cemetery out of game" do
      should transition_from_through("destroyed", "remove")
    end
  end

  should "change to given state" do
    test_card_in_game = CardInGame.create(CardInGame.plan)
    assert test_card_in_game.transition_to("get_ready")
    assert !test_card_in_game.transition_to("activate")
    assert !test_card_in_game.transition_to("not_be_awesome")
  end

  should "test helper methods" do
    test_abstract_card = AbstractCard.create(AbstractCard.plan)
    Card.create(Card.plan)
    test_card_in_game = CardInGame.create(CardInGame.plan)

    assert_equal test_card_in_game.target_type, test_abstract_card.target_type
    assert_equal test_card_in_game.name, test_abstract_card.name
    assert_equal test_card_in_game.loading, test_abstract_card.loading
    assert_equal test_card_in_game.path_to_img, test_abstract_card.path_to_img
    assert_equal test_card_in_game.description, test_abstract_card.description
    assert_equal test_card_in_game.talent, test_abstract_card.talent
    assert_equal test_card_in_game.mana, test_abstract_card.mana
  end

  should "test helper methods for units" do
    test_abstract_card = AbstractCard.create(AbstractCard.plan)
    Unit.create(Unit.plan)
    Card.create(Card.plan)
    test_card_in_game = CardInGame.create(CardInGame.plan)

    assert_equal test_card_in_game.class_name, test_abstract_card.unit.class.name
    assert_nil test_card_in_game.duration
  end

  should "test helper methods for spells" do
    test_abstract_card = AbstractCard.create(AbstractCard.plan)
    Spell.create(Spell.plan)
    Card.create(Card.plan)
    test_card_in_game = CardInGame.create(CardInGame.plan)

    assert_equal test_card_in_game.class_name, test_abstract_card.spell.class.name
    assert_equal test_card_in_game.duration, test_abstract_card.spell.duration
    assert_nil test_card_in_game.attack
    assert_nil test_card_in_game.health
  end
end
