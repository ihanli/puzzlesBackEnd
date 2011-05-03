require 'test_helper'

class BattleTest < ActiveSupport::TestCase
  should "validate object and state after creation" do
    test_battle = Battle.create
    assert_valid test_battle
    assert test_battle.opened?
  end
  
  should "test draw event" do
    test_battle = Battle.create
    test_battle.draw!
    assert test_battle.drawing?
    
    test_battle.state = "attacking"
    assert test_battle.attacking?
    test_battle.draw!
    assert test_battle.drawing?
    
    test_battle.state = "placing"
    assert test_battle.placing?
    test_battle.draw!
    assert test_battle.drawing?
  end
  
  should "test place event" do
    test_battle = Battle.create
    test_battle.place!
    assert test_battle.placing?
    
    test_battle.state = "drawing"
    assert test_battle.drawing?
    test_battle.place!
    assert test_battle.placing?
  end
  
  should "test attack event" do
    test_battle = Battle.create
    
    test_battle.state = "drawing"
    assert test_battle.drawing?
    test_battle.attack!
    assert test_battle.attacking?
    
    test_battle.state = "placing"
    assert test_battle.placing?
    test_battle.attack!
    assert test_battle.attacking?
  end
  
  should "test finish event" do
    test_battle = Battle.create
    
    test_battle.finish!
    assert test_battle.finished?
    
    test_battle.state = "drawing"
    assert test_battle.drawing?
    test_battle.finish!
    assert test_battle.finished?
    
    test_battle.state = "placing"
    assert test_battle.placing?
    test_battle.finish!
    assert test_battle.finished?
    
    test_battle.state = "attacking"
    assert test_battle.attacking?
    test_battle.finish!
    assert test_battle.finished?
  end
end
