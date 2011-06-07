require 'test_helper'

class BattleTest < ActiveSupport::TestCase
  should "validate object and state after creation" do
    test_battle = Battle.create
    assert_valid test_battle
    assert test_battle.pending?
  end

  context "state machine event =>" do
    setup do
      subject { Battle.create(Battle.plan) }
    end

    context "drawing right after start of battle" do
      should transition_from_through("opened", "draw")
    end

    context "draw event after attack" do
      should transition_from_through("attacking", "draw")
    end

    context "draw event after card was placed" do
      should transition_from_through("placing", "draw")
    end

    context "regular placing" do
      should transition_from_through("opened", "place")
    end

    context "placing drawn card" do
      should transition_from_through("drawing", "place")
    end

    context "enter attack phase without placing cards" do
      should transition_from_through("drawing", "attack")
    end

    context "attack after card was placed" do
      should transition_from_through("placing", "attack")
    end
#    FIXME: write alternative test for tests of 'finished' state
#    context "finish battle after first turn" do
#      should transition_from_through("opened", "finish")
#    end
#
#    context "finish battle after card was drawn" do
#      should transition_from_through("drawing", "finish")
#    end
#
#    context "finish battle after card was placed" do
#      should transition_from_through("placing", "finish")
#    end
#
#    context "finish battle after attack phase" do
#      should transition_from_through("attacking", "finish")
#    end
  end
end
