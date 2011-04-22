require 'test_helper'

class DecksControllerTest < ActionController::TestCase
  should "get :index" do
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
    assert_response :success
  end
    
  context "show" do
    setup do
      Deck.create(Deck.plan)
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => 1
    end
    
    should respond_with(:success)
  end
  
  context "create" do
    setup do
      post :create, :deck => Deck.plan
    end

    should respond_with(:redirect)
  
    should "create a deck" do
      assert_equal 1, Deck.count
    end
  end
  
  context "destroy" do
    setup do
      Deck.create(Deck.plan)
      delete :destroy, :id => 1
    end
    
    should respond_with(:redirect)
    
    should "delete a deck" do
      assert_equal 0, Deck.count
    end
  end
end
