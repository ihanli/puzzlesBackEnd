require 'test_helper'

class UserTest < ActiveSupport::TestCase

	should validate_presence_of(:fb_id)
	should validate_presence_of(:experience)
	
	should "validate min expercience" do
		assert_valid User.make_unsaved
		assert !User.make_unsaved(:experience => -1).valid?
	end
	
	should "validate facebook id" do
		assert_valid User.make_unsaved
		assert !User.make_unsaved(:fb_id => -1).valid?
	end
end
