require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context "register and login user" do
    setup do
      post :register_and_login, :id => 2655
    end
    
    should "have registered the user" do
      assert_equal 1, User.count
    end
    
    should "have logged in user" do
      assert_equal session[:fbid], 2655
    end
    
    should "grant access" do
      get :show, "id" => User.find_by_fb_id(2655).id
      assert respond_with(:success)
    end
    
    should "logout inactive user" do
      session[:expiry_time] = nil
      get :show, "id" => User.find_by_fb_id(2655).id
      assert respond_with(:error)
    end
  end

  context "create" do
    setup do
      post :create, :user => User.plan
    end

    should respond_with(:redirect)
  
    should "create a user" do
      assert_equal 1, User.count
    end
  end
  
  context "try to create user with invalid id" do
    setup do
      post :create, :user => { :fb_id => -1, :experience => 15 }
    end
    
    should respond_with(:error)
  end
  
  context "destroy" do
     setup do
       User.create(User.plan)
       post :register_and_login, :id => User.find_by_id(1).fb_id
       delete :destroy, :id => 1
     end
     
     should respond_with(:redirect)
     
     should "delete a user" do
       assert_equal 0, User.count
       session[:expiry_time] = nil
     end
  end
end
