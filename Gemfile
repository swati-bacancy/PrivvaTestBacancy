# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Use for creating data
  gem 'factory_bot_rails', '6.1'
  # Use for create fake data
  gem 'faker', '2.13'
  # Use for template render in rspec
  gem 'rails-controller-testing', '1.0.5'
  # Use for rspec
  gem 'rspec-rails', '4.0.1'
  # Use for debug
  gem 'pry-rails'
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use for clean database
  gem 'database_cleaner-active_record', '1.8'
  # Use for clean database
  gem 'database_cleaner-redis', '1.8'
  # Use for find coverage of rspec
  gem 'simplecov', '0.18.5', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'active_model_serializers'
gem 'devise'
gem 'kaminari', '1.2.1'
gem 'simple_token_authentication'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
