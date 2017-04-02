source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'russian', '0.6.0'
gem 'bootstrap-sass', '~> 3.3.5'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'will-paginate-i18n'
gem 'slim-rails'
gem 'simple_form'
gem 'devise'
gem 'devise-i18n'
gem 'cancancan'
gem 'codemirror-rails'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :development do
  gem 'annotate'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-rails'
  gem 'pry'
  gem 'better_errors'
  gem 'binding_of_caller'
end
