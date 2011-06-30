require 'test_helper'

class CardInGamesControllerTest < ActionController::TestCase
  should "update state and target" do
    card = CardInGame.create(CardInGame.plan)
    put :update, {:id => card.id, :target => 33}
    assert_response :ok
    card = CardInGame.find_by_id(1)
    assert_equal 33, card.target_id
  end
end
