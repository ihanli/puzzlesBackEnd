require 'test_helper'

class DecksIntegrationTest < ActionDispatch::IntegrationTest
  should "show all decks of an user" do
    Deck.make(Deck.plan)
    visit decks_path
    assert respond_with(:success)
  end
  
  should "show a single deck" do
    Deck.create(Deck.plan)
    visit battle_path(1)
    assert respond_with(:success)
#    doc = Nokogiri::XML(@response.body)
  end
end