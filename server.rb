#!/usr/bin/ruby

%w{rubygems sinatra haml data_mapper parseconfig json}.each { |x| require x }

#Load the configuration file using ConfigParser
config = ParseConfig.new File.dirname(__FILE__) + '/app.conf'

#common settings
#note: using lambdas to make one liners 
set :port, config["port"]
set :environment, -> { !!config["development"] ? (config["development"] == "true" ? :test : :production) : :production }.call 
set :public_folder, File.dirname(__FILE__) + '/' + config["public_folder"]
set :haml, :format => -> { !!config["html5"] ? (config["html5"] == "true" ? :html5 : :xhtml) :xhtml }.call

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


#Handler for default view - Throw all content from the database
class View
  attr_accessor :data
  def initialize 
    self.data = Contact.all
  end
end

module Handle
  attr_accessor :json, :status, :message
  
end

class Create
  include Handle
  def action
       return "asdf"
  end
end
 
class Handler
  attr_accessor :data
  @@allowed_actions = ["create", "delete", "show", "edit"]
  def initialize(post)
    self.method(post[:action].to_sym).call post[:name], post[:phone] if @@allowed_actions.include? post[:action]
  end
  def test
    
  end
  def create(name, phone)
    c = Contact.create(:name=>name, :phone=>name)
    redirect "/test"
  end
  def delete(name, phone="")
    return "asdf"
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
  
  get "/test" do
    p params
  end
  # The REST API for handling all data
  post '/handle' do
    outputObject = Handler.new params
    #here it is a json data
    @output = outputObject.data
  end
end

#Run this as the last line of the application. To track all the classes that use the module Handle
p Handle.constants.select
Handle.constants.select do |c|
  p "asdfadfs"
  if Class === Handle.const_get(c)
    p c
  end
end
