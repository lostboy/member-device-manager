source 'https://rubygems.org'

ruby '2.1.2'

# Ruby on Rails is a full-stack web framework
gem 'rails', '~> 4.1.0'

# Pg is the Ruby interface to the PostgreSQL RDBMS
gem 'pg'

# Makes http fun
gem 'httparty'

# Net::SSH: a pure-Ruby implementation of the SSH2 client protocol.
gem 'net-ssh', '~> 2.9.1'

# Instant CSV support for Rails
gem 'as_csv'

# Sass adapter for the Rails asset pipeline
gem 'sass-rails', '~> 4.0.3'

# Minifies JavaScript files
gem 'uglifier', '>= 1.3.0'

# CoffeeScript adapter for the Rails asset pipeline
gem 'coffee-rails', '~> 4.0.0'

# IPAddress is a Ruby library designed to make manipulation of IPv4 and IPv6
# addresses both powerful and simple.
gem 'ipaddress', github: 'bluemonk/ipaddress'

# Track changes to your models' data.
gem 'paper_trail', '~> 3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Injects Angular.js into your asset pipeline
gem 'angularjs-rails'

# Lo-Dash for the Rails asset pipeline
gem 'lodash-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Serialize JSON with OJ
gem 'oj'

# Use Pry as your rails console
gem 'pry-rails'

# Unicode support for Hirb
gem 'hirb-unicode'

# Roles have never been easier
gem 'role_model'

# Simple, Rails app configuration using a single YAML file
gem 'figaro'

# Simple, efficient background processing for Ruby
gem 'sidekiq', '~> 3.0'

# Used for Sidekiq monitoring page
gem 'sinatra', require: false

# The administration framework for Ruby on Rails
gem 'activeadmin', github: 'gregbell/active_admin'

# Flexible authentication solution for Rails
gem 'devise'

# Simple authorization solution for Rails
gem 'cancan'

# A comprehensive framework of Sass mixins
gem 'bourbon'

# A scheduler process
gem 'clockwork'

# Use unicorn as the app server
gem 'unicorn'

# unicorn-rails overrides the Rack::Handler.default method to return Rack::Handler::Unicorn which will cause rack (and rails) to use unicorn by default.
gem "unicorn-rails"

# A Ruby implementation of the Coveralls API.
gem 'coveralls'

group :test do
  # Simple testing of Sidekiq jobs
  #gem 'rspec-sidekiq'
end

group :test, :development do
  # Rails application preloader
  gem 'spring'

  # Writes validation error messages to the log
  gem 'whiny_validation'

  # RSpec for Rails
  gem 'rspec-rails', '~> 3.0.0'

  # RSpec command for Spring
  gem 'spring-commands-rspec'

  # Integration between FactoryGirl and Rails
  gem 'factory_girl_rails'

  # Used to easily generate fake data
  gem 'faker'

  # A command line tool to easily handle events on file system modifications
  gem 'guard'

  # Guard::RSpec automatically run your specs
  gem 'guard-rspec'

  # Provides a better error page for Rails
  gem 'better_errors'

  # Retrieve the binding of a method's caller
  gem 'binding_of_caller'
end

group :staging, :production do
  # Use ngmin in the Rails asset pipeline
  gem 'ngmin-rails'
end
