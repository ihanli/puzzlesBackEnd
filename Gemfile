source 'http://rubygems.org'

gem 'rails', '3.0.5'
gem 'capistrano'
gem 'flay'
gem 'flog'

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'mysql2'
end

group :test do
  gem 'machinist'
  gem 'faker', '0.3.1'
  gem 'shoulda'
  gem 'capybara'
  gem 'mocha', :require => false
end