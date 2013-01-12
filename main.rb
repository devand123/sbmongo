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

  key :title, String
  key :body, String
  key :author, String
  key :number_of_edits, Integer
  key :last_edit, Time
  timestamps!


  attr_accessible :title, :body, :author

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

  get '/:id/edit' do
    @documents = Document.all
    @document = Document.find(params[:id])
    slim :edit
  end

  get '/new' do
    #document = Document.new
    slim :new
  end

  post '/create' do

    document = Document.new
    document.title = (params[:title])
    document.body = (params[:body])
    document.author = (params[:author])

    if document.save
      status 201
    else
      status 401
    end
    redirect '/'
  end

  put '/:id/update' do
    document = Document.find(params[:id])
    document.title = (params[:title])

    if Document.save
      status 201
    else
      status 401
    end

    redirect '/'

  end

  get '/:id/delete' do
    @documents = Document.all
    @document = Document.find(params[:id])
    slim :delete
  end

  delete '/:id/delete' do
    document.find(params[:id]).destroy
    redirect '/'
  end