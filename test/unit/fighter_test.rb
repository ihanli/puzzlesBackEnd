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

  context "state machine event =>" do
    setup do
      subject { Fighter.create(Fighter.plan) }
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
