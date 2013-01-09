require 'spec_helper'



describe 'Mongo SB' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

context "home page" do

  subject { last_response }

  it "should display header" do
    get '/'
    last_response.body.should include("Mongo Sandbox")
  end


  it { last_response.should render_template(:index) }

end

context "new movie" do

  it "page should display header" do
    get '/new'
    last_response.body.should include ("New Movie")
  end
end

context "show movie" do

  it "page should display header" do
    get '/new'
    last_response.body.should include ("New Movie")
  end
end

context "destroy movie" do

  it "page should display header" do
    get '/new'
    last_response.body.should include ("New Movie")
  end
  end

context "edit movie" do

  it "page should display header" do
    get '/new'
    last_response.body.should include ("New Movie")
  end
end




end