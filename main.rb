require 'pry'
require 'sinatra'
require 'sqlite3'
require 'data_mapper'


# DATABASE = SQLite3::Database.new('warehouse.db')

# Here, we load category, location and product files so we don't need to in 
# every file

require_relative "category"
require_relative "location"
require_relative "product"

get "/" do
  erb :home, :layout => :boilerplate 
end

DataMapper::setup(:default, "sqlite3://warehouse.db")
  class Product
  include DataMapper::Resource
  property :id, Serial
  property :name, Text, :required => true
  property :description, Text, :required => true
  property :cost, Integer, :required => true
  property :serial, Text, :required => true
  property :location_id, Integer
  property :category_id, Integer
  property :quantity, Integer, :required => true
  end
  
  class Category
  include DataMapper::Resource
  property :id, Serial
  property :manufacturer, Text, :required => true
  end
  
  class Location
  include DataMapper::Resource
  property :id, Serial
  property :location_name, Text, :required => true
  end
DataMapper.finalize.auto_upgrade!

get "/product" do
  
  logger.info params
  @name = "#{params["name"]}"
  @description = "#{params["description"]}"
  @cost = "#{params["cost"]}"
  @serial = "#{params["serial"]}"
  @quantity = "#{params["quantity"]}"
  @location_id = "#{params["location_id"]}"
  @category_id = "#{params["category_id"]}"
  erb :product, :layout => :boilerplate
  
# new_product = Product.new("name" => name, "description" => description,
# "cost" => cost, "serial" => serial, "quantity" => quantity, "location_id" =>
# "null", "category_id" => "null")


end

