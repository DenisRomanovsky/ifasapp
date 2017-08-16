# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.9'
# Use pg as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  # Catches email. See 1080 port to check em all.
  gem 'mailcatcher'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Rubocop!
  gem 'rubocop', require: false

  # Reek
  gem 'reek'

  # Annotates
  gem 'annotate', require: false
end

group :production do
  # Real web server
  gem 'puma'
end

# TODO: Check rails 5 availability now and then.
gem 'activeadmin', github: 'activeadmin'
# Auth stuff.
gem 'devise'
# Some translations for devise
gem 'devise-i18n'
# haml
gem 'haml'
# Cool bootstrap forms.
gem 'bootstrap_form'
# Bootstrap itself.
gem 'bootstrap-sass', '~> 3.3.6'
# Russian bears, sluts and Vodka
gem 'russian'
# Some work to do on background.
gem 'resque', '~> 1.24.1'
# Resuqe obey to schedule!
gem 'resque-scheduler'
# Resque web interface. To make 'WTF O_o' less often.
gem 'resque-web', require: 'resque_web'
# Humanity for the URLs
gem 'friendly_id', '~> 5.1.0'
# Obey and paginate, motherfucker.
gem 'will_paginate', '~> 3.1.1'

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
  gem 'poltergeist'
  gem 'shoulda-matchers', '~> 3.1'
end

# New relic guard is here!
gem 'newrelic_rpm'

# Log entries.
gem 'le'

# Specify ruby version to use dig for hashes.
ruby '~> 2.4.0'
