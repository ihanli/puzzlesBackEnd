require 'test_helper'

class BattleTest < ActiveSupport::TestCase
  should "validate object and state after creation" do
    test_battle = Battle.create
    assert_valid test_battle
    assert test_battle.opened?
  end
  
  should "test drawing right after start of battle" do
    test_battle = Battle.create
    test_battle.draw!
    assert test_battle.drawing?
  end
  
  should "test draw event after attack" do
    test_battle = Battle.create
    test_battle.state = "attacking"
    assert test_battle.attacking?
    test_battle.draw!
    assert test_battle.drawing?
  end

  should "test draw event after card was placed" do
    test_battle = Battle.create
    test_battle.state = "placing"
    assert test_battle.placing?
    test_battle.draw!
    assert test_battle.drawing?
  end
  
  should "test regular placing" do
    test_battle = Battle.create
    test_battle.place!
    assert test_battle.placing?
  end
  
  should "test placing drawn card" do
    test_battle = Battle.create
    test_battle.state = "drawing"
    assert test_battle.drawing?
    test_battle.place!
    assert test_battle.placing?
  end
  
  should "test if attack phase is entered without placing cards" do
    test_battle = Battle.create
    test_battle.state = "drawing"
    assert test_battle.drawing?
    test_battle.attack!
    assert test_battle.attacking?
  end
  
  should "test attack event after card was placed" do
    test_battle = Battle.create
    test_battle.state = "placing"
    assert test_battle.placing?
    test_battle.attack!
    assert test_battle.attacking?
  end
  
  should "test if battle is finished after first turn" do
    test_battle = Battle.create
    test_battle.finish!
    assert test_battle.finished?
  end
  
  should "test if battle is finished after card was drawn" do
    test_battle = Battle.create
    test_battle.state = "drawing"
    assert test_battle.drawing?
    test_battle.finish!
    assert test_battle.finished?
  end
  
  should "test if battle is finished after card was placed" do
    test_battle = Battle.create
    test_battle.state = "placing"
    assert test_battle.placing?
    test_battle.finish!
    assert test_battle.finished?
  end
  
  should "test if battle is finished after attack phase" do
    test_battle = Battle.create
    test_battle.state = "attacking"
    assert test_battle.attacking?
    test_battle.finish!
    assert test_battle.finished?
  end
end
