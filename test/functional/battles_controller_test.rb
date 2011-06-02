require 'test_helper'
require 'nokogiri'

class BattlesControllerTest < ActionController::TestCase
  should "get :index" do
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
    assert_response :success
  end
  
  context "show" do
    setup do
      Battle.create(Battle.plan)
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => 1
    end
    
    should respond_with(:success)
  end
  
  context "create" do
    setup do
      post :create, :battle => Battle.plan, :fighter => Fighter.plan
    end

    should respond_with(:redirect)
  
    should "create a battle" do
      assert_equal 1, Battle.count
    end
  end
  
  context "destroy" do
    setup do
      Battle.create(Battle.plan)
      delete :destroy, :id => 1
    end
    
    should respond_with(:redirect)
    
    should "delete a battle" do
      assert_equal 0, Battle.count
    end
  end
end
