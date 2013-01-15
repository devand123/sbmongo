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
  key :body, String, :required => true
  key :author, String, :required => true
  key :number_of_edits, Integer, :required => true
  timestamps!


  attr_accessible :title, :body, :author, :number_of_edits

end

class User

  include MongoMapper::Document

  key :user_id, String
  key :document_id, Integer
  key :number_of_chars_changed, Integer
  key :number_of_docs_changed, Integer
  key :ip_address, Integer
  timestamps!

end



#Routes Section
#==============

  get '/' do
    @documents = Document.all
    slim :index
  end

  get '/edit/:id' do
    @document = Document.find(params[:id])
    slim :edit
  end

  get '/new' do
    slim :new
  end

  post '/create' do
    error 401 unless params[:auth_token] =~ /^xyz/
    document = Document.new
    document.title = (params[:title])
    document.body = (params[:body])
    document.author = (params[:author])
    document.number_of_edits = 1

    if document.save
      status 201
    else
      status 401
    end
    redirect '/'
  end

  put '/update/:id' do
    error 401 unless params[:auth_token] =~ /^xyz/
    document = Document.find(params[:id])
    document.title = (params[:title])
    document.body = (params[:body])
    document.author = (params[:author])
    document.number_of_edits += 1

    if document.save
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