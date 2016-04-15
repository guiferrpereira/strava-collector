source 'https://rubygems.org'

gem 'rails', '4.2.3'
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'strava-api-v3', git: "https://github.com/guiferrpereira/strava-api-v3.git", branch: 'friend_endpoints'

gem 'redis'
gem 'representable'
gem 'whenever', :require => false



group :development do
  # Deploy with Capistrano
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
end

group :production do
  gem 'therubyracer'

  # Use Unicorn as the app server
  gem 'unicorn'
end

