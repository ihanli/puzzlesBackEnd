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
	
  should "validate object and state after creation" do
    test_card = Card.create(Card.plan)
    assert_valid test_card
    assert test_card.off_game?
  end
	
	should "bring card into game" do
    test_card = Card.create(Card.plan)
    test_card.get_ready!
    assert test_card.ready_to_play?
	end
	
	should "draw card from deck" do
    test_card = Card.create(Card.plan)
    test_card.get_ready!
    test_card.draw!
    assert test_card.drawn?
	end
	
  should "draw card from cemetery" do
     test_card = Card.create(Card.plan)
     test_card.state = "destroyed"
     test_card.draw!
     assert test_card.drawn?
  end
   
  should "take summoned card back" do
     test_card = Card.create(Card.plan)
     test_card.state = "summoned"
     test_card.draw!
     assert test_card.drawn?
  end
   
  should "take casted card back" do
     test_card = Card.create(Card.plan)
     test_card.state = "casted"
     test_card.draw!
     assert test_card.drawn?
  end
   
  should "take back inactive card" do
     test_card = Card.create(Card.plan)
     test_card.state = "inactive"
     test_card.draw!
     assert test_card.drawn?
  end
   
  should "deactivate summoned unit" do
     test_card = Card.create(Card.plan)
     test_card.state = "summoned"
     test_card.deactivate!
     assert test_card.inactive?
  end
   
  should "place unit on field" do
     test_card = Card.create(Card.plan)
     test_card.state = "drawn"
     test_card.place_unit!
     assert test_card.inactive?
  end
   
  should "summon unit from deck" do
     test_card = Card.create(Card.plan)
     test_card.get_ready!
     test_card.summon!
     assert test_card.summoned?
  end
   
  should "summon unit instantly" do
     test_card = Card.create(Card.plan)
     test_card.state = "drawn"
     test_card.summon!
     assert test_card.summoned?
  end
   
  should "summon destroyed unit" do
     test_card = Card.create(Card.plan)
     test_card.state = "destroyed"
     test_card.summon!
     assert test_card.summoned?
  end
   
  should "activate inactive unit" do
     test_card = Card.create(Card.plan)
     test_card.state = "inactive"
     test_card.activate!
     assert test_card.summoned?
  end
  
  should "cast spell from deck" do
    test_card = Card.create(Card.plan)
    test_card.get_ready!
    test_card.cast!
    assert test_card.casted?
  end
  
  should "cast drawn spell" do
    test_card = Card.create(Card.plan)
    test_card.state = "drawn"
    test_card.cast!
    assert test_card.casted?
  end
  
  should "cast spell from cemetery" do
    test_card = Card.create(Card.plan)
    test_card.state = "destroyed"
    test_card.cast!
    assert test_card.casted?
  end
	
	should "attack after activation" do
    test_card = Card.create(Card.plan)
    test_card.state = "summoned"
    test_card.attack!
    assert test_card.attacking?
	end
	
  should "bring card back from cemetery" do
     test_card = Card.create(Card.plan)
     test_card.state = "destroyed"
     test_card.get_ready!
     assert test_card.ready_to_play?
  end
	
  should "destroy card from deck" do
     test_card = Card.create(Card.plan)
     test_card.get_ready!
     test_card.destroy!
     assert test_card.destroyed?
  end
	
  should "destroy drawn card" do
     test_card = Card.create(Card.plan)
     test_card.state = "drawn"
     test_card.destroy!
     assert test_card.destroyed?
  end
	
  should "destroy summoned unit" do
     test_card = Card.create(Card.plan)
     test_card.state = "summoned"
     test_card.destroy!
     assert test_card.destroyed?
  end
	
  should "destroy casted spell" do
     test_card = Card.create(Card.plan)
     test_card.state = "casted"
     test_card.destroy!
     assert test_card.destroyed?
  end
	
  should "destroy attacking unit" do
     test_card = Card.create(Card.plan)
     test_card.state = "attacking"
     test_card.destroy!
     assert test_card.destroyed?
  end
	
  should "take card from deck out of game" do
     test_card = Card.create(Card.plan)
     test_card.get_ready!
     test_card.remove_from_game!
     assert test_card.off_game?
  end
	
  should "take drawn card out of game" do
     test_card = Card.create(Card.plan)
     test_card.state = "drawn"
     test_card.remove_from_game!
     assert test_card.off_game?
  end
	
  should "take summoned unit out of game" do
     test_card = Card.create(Card.plan)
     test_card.state = "summoned"
     test_card.remove_from_game!
     assert test_card.off_game?
  end
	
  should "take inactive unit out of game" do
     test_card = Card.create(Card.plan)
     test_card.state = "inactive"
     test_card.remove_from_game!
     assert test_card.off_game?
  end
	
  should "take casted spell out of game" do
     test_card = Card.create(Card.plan)
     test_card.state = "casted"
     test_card.remove_from_game!
     assert test_card.off_game?
  end
	
  should "take attacking unit out of game" do
     test_card = Card.create(Card.plan)
     test_card.state = "attacking"
     test_card.remove_from_game!
     assert test_card.off_game?
  end
	
  should "take card from cemetery out of game" do
     test_card = Card.create(Card.plan)
     test_card.state = "destroyed"
     test_card.remove_from_game!
     assert test_card.off_game?
  end
end
