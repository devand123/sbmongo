require 'spec_helper'



describe 'Mongo SB' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

context "routes" do

  subject { last_response }

  it 'should return a 200 on the home page' do
    get '/'
    last_response.status.should == 200
  end

  it 'should return ok on the home page' do
    get '/'
    should be_ok
  end


  context "for movies" do

    it 'should return a 200 on the new page' do
      get '/new'
      last_response.status.should == 200
    end

    it 'should return ok on the new page' do
      get '/new'
      should be_ok
    end

    it 'should return a 200 on the create page' do
      post '/movies'
      last_response.status.should == 200
    end

    it 'should return ok on the create page' do
      post '/movies'
      should be_ok
    end

    it 'should return a 200 on the get page' do
      get '/movie/' + @movie
      last_response.status.should == 200
    end

    it 'should return ok on the get page' do
      get '/movie/' + @movie
      should be_ok
    end

    it 'should return a 200 on the post page' do
      put '/movie/' + @movie
      last_response.status.should == 200
    end

    it 'should return ok on the post page' do
      put '/movie/' + @movie
      should be_ok
    end

    it 'should return a 200 on the delete page' do
      delete '/movie/' + @movie
      last_response.status.should == 200
    end

    it 'should return ok on the delete page' do
      delete '/movie/' + @movie
      should be_ok
    end

    it 'should return a 200 on the edit page' do
      delete '/movie/' + @movie + '/edit'
      last_response.status.should == 200
    end

    it 'should return ok on the edi page' do
      delete '/movie/' + @movie + '/edit'
      should be_ok
    end

  end

end

end