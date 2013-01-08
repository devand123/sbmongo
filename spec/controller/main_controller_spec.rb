require 'spec_helper'



describe 'MyApp' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

context "home page" do

  it "should display appropriate content" do
    get '/'
    last_response.should be_ok
    last_response.body.should include("Mongo Sandbox")
  end



end