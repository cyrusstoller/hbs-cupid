source 'https://rubygems.org'

ruby '2.1.2'
gem 'rails', '4.2.0'
gem 'pg', '0.18.1'

gem 'sass-rails', '~> 5.0.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '>= 2.5.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem "will_paginate", "~> 3.0.7"
gem 'will_paginate-foundation'

gem 'foundation-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.2.6'

group :development, :test do
  gem "foreman", "~> 0.77.0"
  
  gem 'annotate', '~> 2.6.3'
  gem "rspec-rails", "~> 3.2.0"
  gem "guard-rspec", "~> 4.5.0", :require => false
  gem "factory_girl_rails", "~> 4.5.0"

  gem 'spring', '~> 1.2.0'
  gem "spring-commands-rspec"
end

group :test do
  gem 'rb-fsevent', '~> 0.9.4', :require => false
  gem 'terminal-notifier-guard'
  gem "growl", "~> 1.0.3"

  # # Test gems for Linux
  # gem 'rb-inotify', '0.8.8'
  # gem 'libnotify', '0.5.9'

  # # Test gems for Windows
  # gem 'rb-fchange', '0.0.5'
  # gem 'rb-notifu', '0.0.4'
  # gem 'win32console', '1.3.0'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  gem 'rails_12factor'
end

gem 'dotenv-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
gem 'unicorn', '~> 4.8.2'
gem 'unicorn-worker-killer', "~> 0.4.3"

# Authentication
gem "devise", "~> 3.4.1"
gem "cancancan", "~> 1.10.1"

# Use debugger
# gem 'debugger', group: [:development, :test]
