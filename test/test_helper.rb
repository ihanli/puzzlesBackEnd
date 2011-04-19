ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'mocha'

class ActiveSupport::TestCase
  setup { Sham.reset }
end

require File.expand_path(File.dirname(__FILE__) + "/blueprints")

require 'capybara/rails'

class ActionDispatch::IntegrationTest
 include Capybara
end