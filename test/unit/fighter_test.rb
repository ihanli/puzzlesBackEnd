require 'test_helper'

class FighterTest < ActiveSupport::TestCase
  should "validate lower bound of mana" do
    assert_valid Fighter.make_unsaved
    assert !Fighter.make_unsaved(:mana => -1).valid?
  end

  should "validate health range" do
    assert_valid Fighter.make_unsaved
    assert !Fighter.make_unsaved(:health => -1).valid?
    assert !Fighter.make_unsaved(:health => 26).valid?
  end
  
  should "validate object and state after creation" do
    test_fighter = Fighter.create(Fighter.plan)
    assert_valid test_fighter
    assert test_fighter.ready?
  end
  
  should "test proceed event" do
    test_fighter = Fighter.create(Fighter.plan)
    
    test_fighter.proceed!
    assert test_fighter.proceeding?
    
    test_fighter.wait!
    assert test_fighter.waiting?
    test_fighter.proceed!
    assert test_fighter.proceeding?
  end
  
  should "test wait event" do
    test_fighter = Fighter.create(Fighter.plan)
    
    test_fighter.wait!
    assert test_fighter.waiting?
    
    test_fighter.proceed!
    assert test_fighter.proceeding?
    test_fighter.wait!
    assert test_fighter.waiting?
  end

  should "test finish event" do
    test_fighter = Fighter.create(Fighter.plan)
    
    test_fighter.wait!
    assert test_fighter.waiting?
    test_fighter.finish!
    assert test_fighter.finished?
    
    test_fighter.state = "proceeding"
    assert test_fighter.proceeding?
    test_fighter.finish!
    assert test_fighter.finished?
  end
end
