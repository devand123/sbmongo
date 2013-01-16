#Required Gems
#=============

require 'sinatra'



#Configuration
#=============

MongoMapper.database = 'simpleenglish'




#Mapping out our DB/Schema
#==========================

  #NAMING GUIDELINES
  #=================
  #1) Underscores used for naming Fields
  #2) Uppercase Camel Case for naming collections


class Document

  include MongoMapper::Document

  key :title, String, :required => true
  key :body, Array, :required => true
  key :author, String, :required => true
  key :number_of_edits, Integer, :required => true
  key :contributor_ids, Array
  many :users, :in => :contributor_ids
  timestamps!

  attr_accessible :title, :body, :author, :number_of_edits

end

class User

  include MongoMapper::Document

  key :user_id, String, :required => true, :unique => true
  key :name, String, :required => true
  timestamps!

end


#Helpers Section
#===============
first_name = ["slick", "windy", "velvet", "micro"]

second_name = ["dinosaur", "poet", "lion", "writer", "autodidact"]


def token_from_form_verified()
  error 401 unless params[:auth_token] =~ /^xyz/
end


#Routes Section
#==============

enable :sessions

  get '/' do
    @users = User.all
    @documents = Document.all
    slim :index
  end



  get '/edit/:id' do
    document = Document.find(params[:id])
    @document = document
    @body = document.body.join(".") + "."
    slim :edit
  end

  get '/login' do
    session[:remote_ip] =  request.env['REMOTE_ADDR'].split(',').first
    user = User.find({user_id: session[:remote_ip]})
    if user.nil?
      user = User.new
      user.user_id = session[:remote_ip]
      user.name = first_name.sample + "-" + second_name.sample + "-" + session[:remote_ip]
      if user.save
        session[:user_name] = user.name
        status 202
      else
        status 401
      end
    else
      session[:user_name] = user.name
    end
    redirect '/'
  end

  get '/new' do
    if session[:user_name].nil?
      redirect '/login'
    else
      slim :new
    end
  end



  post '/create' do

    token_from_form_verified()

    if session[:user_name].nil?
      redirect '/login'
    end

    #Injecting Document Attributes into new Document
    document = Document.new
    document.title = (params[:title])
    document.body = (params[:body]).split(".")
    document.author = (params[:author])
    document.number_of_edits = 1
    document.contributor_ids = session[:remote_ip]

    #Saving Document
    if document.save
      status 201
    else
      status 401
    end
    redirect '/'
  end



  put '/update/:id' do

    token_from_form_verified()


    if session[:user_name].nil?
      redirect '/login'
    end

    document = Document.find( params[:id] )
    document.title = ( params[:title] )
    document.body = ( params[:body] )
    document.author = ( params[:author] )
    document.number_of_edits += 1
    document.add_to_set( :contributor_ids => session[:remote_ip] )

    if document.update_attributes!
      status 201
    else
      status 401
    end

    redirect '/'

  end



  delete '/delete/:id' do
    error 401 unless params[:auth_token] =~ /^xyz/
    Document.find(params[:id]).destroy
    redirect '/'
  end