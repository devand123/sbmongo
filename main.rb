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
  timestamps!

  attr_accessible :title, :body, :author, :number_of_edits

end



#Helpers Section
#===============


def token_from_form_verified()
  error 401 unless params[:auth_token] =~ /^xyz/
end


#Routes Section
#==============

enable :sessions

  get '/' do
    @documents = Document.all
    slim :index
  end

  get '/edit/:id' do
    document = Document.find(params[:id])
    @document = document
    @body = document.body.join(".")
    slim :edit
  end

  get '/new' do
    slim :new
  end

  post '/create' do

    token_from_form_verified()

    #Injecting Document Attributes into new Document
    document = Document.new
    document.title = (params[:title])
    document.body = (params[:body]).split(".")
    document.author = (params[:author])
    document.number_of_edits = 1
    document.contributor_ids = request.env['REMOTE_ADDR'].split(',').first

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

    document = Document.find( params[:id] )
    document.title = ( params[:title] )
    document.body = ( params[:body] )
    document.author = ( params[:author] )
    document.number_of_edits += 1
    document.add_to_set( :contributor_ids => request.env['REMOTE_ADDR'].split(',').first )

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