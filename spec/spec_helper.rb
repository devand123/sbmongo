require File.join(File.dirname(__FILE__), '..', 'main.rb')


#Note that ZenTest and autotest-growl, two gems not installed on here can be used to help with checking tests faster
require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'
require 'slim'
require 'shoulda-matchers'

set :environment, :test

#Sets up database configuration 
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://Jason:pouvoir1!@localhost/blog_development')
RSpec.configure do |config|
  config.before(:each) { DataMapper.auto_migrate! }
end