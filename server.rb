require 'rubygems'
require 'sinatra'
require 'haml'
require 'data_mapper'


#common settings
set :port, 8080
set :environment, :test
set :public_folder, File.dirname(__FILE__) + '/static'
set :haml, :format => :html5

# Model - Handled by data_mapper
class Contact
  
  include DataMapper::Resource
  
  #set the necessary items
  property :id, Serial
  property :name, String
  property :phone, String

end

# Controllers 
class Controllers
  
end

#Views
class 

get '/' do 
  haml :index
end
