#!/usr/bin/ruby
require 'rubygems'
require 'sinatra'
require 'haml'
require 'data_mapper'
require 'parseconfig'

#Load the configuration file using ConfigParser
config = ParseConfig.new File.dirname(__FILE__) + '/app.conf'

#common settings
set :port, config["port"]
set :environment, :test
set :public_folder, File.dirname(__FILE__) + '/' + config["public_folder"]
set :haml, :format => :html5

#initiate the Database
DataMapper.setup(:default, 'sqlite3://' + config['db_abs_path'])

# Model - Handled by data_mapper
class Contact
  include DataMapper::Resource
  #set the necessary items
  property :id, Serial
  property :name, String
  property :phone, String
end

DataMapper::Logger.new($stdout, :debug)
DataMapper.finalize
DataMapper.auto_upgrade!

class View
  attr_accessor :data
  def initialize 
    self.data = Contact.all
    p self.data
  end
end

class Handler
  attr_accessor :data
  def initialize(post)
    if post["action"] == "create"
      c = Contact.create(:name=>post[:name], :phone=>post[:phone])
      puts self.data
    end
  end
end

#Routers - Application is just for binding 
class Application
  # The application interface
  get '/' do 
    outputObject = View.new
    @output = outputObject.data
    haml :index
  end
  
  # The REST API for handling all data
  post '/handle' do
    outputObject = Handler.new params
    #here it is a json data
    @output = outputObject.data
  end
end
