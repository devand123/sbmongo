#Required Gems
require 'sinatra'
require 'data_mapper'


#Routes Section
  get '/' do
    slim :index
  end
