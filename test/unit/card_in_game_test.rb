require 'test_helper'

class CardInGameTest < ActiveSupport::TestCase
  should "validate object and state after creation" do
    test_card_in_game = CardInGame.create(CardInGame.plan)
    assert_valid test_card_in_game
    assert test_card_in_game.off_game?
  end
  
  should "bring card into game" do
    test_card_in_game = CardInGame.create(CardInGame.plan)
    test_card_in_game.get_ready!
    assert test_card_in_game.ready_to_play?
  end
  
  should "draw card from deck" do
    test_card_in_game = CardInGame.create(CardInGame.plan)
    test_card_in_game.get_ready!
    test_card_in_game.draw!
    assert test_card_in_game.drawn?
  end
  
  should "draw card from cemetery" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "destroyed"
     test_card_in_game.draw!
     assert test_card_in_game.drawn?
  end
   
  should "take summoned card back" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "summoned"
     test_card_in_game.draw!
     assert test_card_in_game.drawn?
  end
   
  should "take casted card back" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "casted"
     test_card_in_game.draw!
     assert test_card_in_game.drawn?
  end
   
  should "take back inactive card" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "inactive"
     test_card_in_game.draw!
     assert test_card_in_game.drawn?
  end
   
  should "deactivate summoned unit" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "summoned"
     test_card_in_game.deactivate!
     assert test_card_in_game.inactive?
  end
   
  should "place unit on field" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "drawn"
     test_card_in_game.place_unit!
     assert test_card_in_game.inactive?
  end
   
  should "summon unit from deck" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.get_ready!
     test_card_in_game.summon!
     assert test_card_in_game.summoned?
  end
   
  should "summon unit instantly" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "drawn"
     test_card_in_game.summon!
     assert test_card_in_game.summoned?
  end
   
  should "summon destroyed unit" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "destroyed"
     test_card_in_game.summon!
     assert test_card_in_game.summoned?
  end
   
  should "activate inactive unit" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "inactive"
     test_card_in_game.activate!
     assert test_card_in_game.summoned?
  end
  
  should "cast spell from deck" do
    test_card_in_game = CardInGame.create(CardInGame.plan)
    test_card_in_game.get_ready!
    test_card_in_game.cast!
    assert test_card_in_game.casted?
  end
  
  should "cast drawn spell" do
    test_card_in_game = CardInGame.create(CardInGame.plan)
    test_card_in_game.state = "drawn"
    test_card_in_game.cast!
    assert test_card_in_game.casted?
  end
  
  should "cast spell from cemetery" do
    test_card_in_game = CardInGame.create(CardInGame.plan)
    test_card_in_game.state = "destroyed"
    test_card_in_game.cast!
    assert test_card_in_game.casted?
  end
  
  should "attack after activation" do
    test_card_in_game = CardInGame.create(CardInGame.plan)
    test_card_in_game.state = "summoned"
    test_card_in_game.attack!
    assert test_card_in_game.attacking?
  end
  
  should "bring card back from cemetery" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "destroyed"
     test_card_in_game.get_ready!
     assert test_card_in_game.ready_to_play?
  end
  
  should "destroy card from deck" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.get_ready!
     test_card_in_game.destroy!
     assert test_card_in_game.destroyed?
  end
  
  should "destroy drawn card" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "drawn"
     test_card_in_game.destroy!
     assert test_card_in_game.destroyed?
  end
  
  should "destroy summoned unit" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "summoned"
     test_card_in_game.destroy!
     assert test_card_in_game.destroyed?
  end
  
  should "destroy casted spell" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "casted"
     test_card_in_game.destroy!
     assert test_card_in_game.destroyed?
  end
  
  should "destroy attacking unit" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "attacking"
     test_card_in_game.destroy!
     assert test_card_in_game.destroyed?
  end
  
  should "take card from deck out of game" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.get_ready!
     test_card_in_game.remove_from_game!
     assert test_card_in_game.off_game?
  end
  
  should "take drawn card out of game" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "drawn"
     test_card_in_game.remove_from_game!
     assert test_card_in_game.off_game?
  end
  
  should "take summoned unit out of game" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "summoned"
     test_card_in_game.remove_from_game!
     assert test_card_in_game.off_game?
  end
  
  should "take inactive unit out of game" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "inactive"
     test_card_in_game.remove_from_game!
     assert test_card_in_game.off_game?
  end
  
  should "take casted spell out of game" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "casted"
     test_card_in_game.remove_from_game!
     assert test_card_in_game.off_game?
  end
  
  should "take attacking unit out of game" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "attacking"
     test_card_in_game.remove_from_game!
     assert test_card_in_game.off_game?
  end
  
  should "take card from cemetery out of game" do
     test_card_in_game = CardInGame.create(CardInGame.plan)
     test_card_in_game.state = "destroyed"
     test_card_in_game.remove_from_game!
     assert test_card_in_game.off_game?
  end
end
