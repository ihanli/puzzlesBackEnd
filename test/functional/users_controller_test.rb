require 'test_helper'

class UsersControllerTest < ActionController::TestCase
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
       delete :destroy, :id => 1
     end
     
     should respond_with(:redirect)
     
     should "delete a user" do
       assert_equal 0, User.count
     end
   end
end
