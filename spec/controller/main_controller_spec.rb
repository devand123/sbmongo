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
    last_response.body.should include("")
  end


  it { last_response.should render_template(:index) }

end

context "new document" do

  it "page should display header" do
    get '/new'
    last_response.body.should include ("New document")
  end
end

context "show document" do

  it "page should display header" do
    get '/new'
    last_response.body.should include ("New document")
  end
end

context "destroy document" do

  it "page should display header" do
    get '/new'
    last_response.body.should include ("New document")
  end
  end

context "edit document" do

  it "page should display header" do
    get '/new'
    last_response.body.should include ("New document")
  end
end




end