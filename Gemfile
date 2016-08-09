source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use haml templates
gem 'haml'
gem 'haml-rails'

# Pretty things
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-sass'

# Pretty forms
gem 'simple_form'

# User auth
gem 'devise'

# Image management
gem "paperclip", "~> 4.3"

# Pagination
gem 'kaminari', '~> 0.16.3'

# User Puma as the app server
gem 'puma'

# Country lists
gem 'country_select'

# Rack middleware for handling Cross-Origin Resource Sharing (CORS)
gem 'rack-cors', '~> 0.3.1'

# Ruby linting
gem 'rubocop', '~> 0.42.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Rspec support for rails
  gem 'rspec-rails'
  # Use factories to set up test data
  gem 'factory_girl_rails', '~> 4.0'
  # For acceptance testing
  gem 'capybara'
  # To run specs automatically on file changes
  gem 'guard-rspec'
end

group :test do
  # Clean up data after testing
  gem 'database_cleaner'
  # Handy testing matchers
  gem 'shoulda-matchers'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :production do
  # Make running the Rails app easier on production
  gem 'rails_12factor'
  # Asset hosting: Stick to this version for now http://ruby.awsblog.com/post/TxFKSK2QJE6RPZ/Upcoming-Stable-Release-of-AWS-SDK-for-Ruby-Version-2
  gem 'aws-sdk', '< 2.0'
end

ruby "2.3.1"
