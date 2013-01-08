require 'spec_helper'



describe 'MyApp' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

context "routes" do

  it 'should return a 200 on the home page' do
    get '/'
    last_response.status.should == 200
  end

  it 'should return ok on the home page' do
    get '/'
    last_response.should be_ok
  end


  
end

end