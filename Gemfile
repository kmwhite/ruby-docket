source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Adding ancestry for Tasks
gem 'ancestry'

# Authentication
gem 'devise'

# Markdown Support
gem 'github-markdown'
gem 'github-markup'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem "jquery-tablesorter", "~> 1.9.5"

# Enable gravatar images
gem 'gravatar_image_tag'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Foundation is our frontend framework
gem 'compass'
gem 'foundation-rails'
gem 'foundation-icons-sass-rails'

# Supported DBs
gem "mysql2", group: :mysql
gem "pg", group: :postgres
gem 'sqlite3', group: :sqlite

group :test do
  gem 'machinist'
  gem 'faker'
  gem 'simplecov', :require => false
  gem 'capybara-webkit'
  gem 'rubocop'
end

group :development, :test do
  gem 'pry'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
