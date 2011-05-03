require 'test_helper'

class BattlesIntegrationTest < ActionDispatch::IntegrationTest
  should "show all battles of an user" do
    Battle.make(Battle.plan)
    visit battles_path
    assert respond_with(:success)
  end
  
  should "show a single battle" do
    Battle.make(Battle.plan)
    visit battle_path(1)
    assert respond_with(:success)
  end
end