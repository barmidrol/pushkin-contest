source 'https://rubygems.org'
# ruby '2.1.1'

gem 'rails', '4.0.3'
gem 'pg', '~> 0.17.1'

gem 'sass-rails', '~> 4.0.1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.1'

gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'
gem 'rabl'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'mechanize'
gem 'colored'
gem 'simple_form'
gem 'bootstrap-sass'
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sidetiq'
gem 'pry-rails'
gem 'rest-client', '~> 1.6.7'
gem 'paper_trail', '~> 3.0.1'
gem 'retryable', '~> 1.3.5'


group :development do
  gem 'nifty-generators'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'foreman'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'brakeman', :require => false
  gem 'letter_opener'
  gem 'capistrano', '~> 2.15.5'
  gem 'capistrano-unicorn', require: false
  gem 'rvm-capistrano'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'thin'
end

group :production do
  gem 'unicorn'
end

group :test do
  gem 'database_cleaner', '1.0.1'
  gem "vcr"
  gem "webmock", ">= 1.8.0", "< 1.12"
end
