require 'pry'
require 'sinatra'
require 'sqlite3'

DATABASE = SQLite3::Database.new('database/warehouse.db')

# Here, we load category, location and product files so we don't need to in 
# every file

require_relative "database/database_setup"
require_relative "models/category"
require_relative "models/location"
require_relative "models/product"


get "/" do
  erb :home, :layout => :boilerplate 
end



get "/add_location" do
  erb :add_location, :layout => :boilerplate
end

get "/location" do
  l1 = Location.new("location_name" => "#{params["location_name"]}")
  l1.insert
  logger.info params
  @location_name = "#{params["location_name"]}"
  erb :location, :layout => :boilerplate
end


get "/delete_location" do
  erb :delete_location, :layout => :boilerplate
end

get "/location_delete" do
  l2 = Location.new("id" => "#{params["location_id"]}")
  l2.delete

  erb :delete, :layout => :boilerplate
end



get "/add_category" do
  erb :add_category, :layout => :boilerplate
end

get "/category" do
  c1 = Category.new("manufacturer" => "#{params["manufacturer"]}")
  c1.insert
  logger.info params
  @manufacturer = "#{params["manufacturer"]}"
  erb :category, :layout => :boilerplate
end


get "/delete_category" do
  erb :delete_category, :layout => :boilerplate
end

get "/category_delete" do
  c2 = Category.new("id" => "#{params["category_id"]}")
  c2.delete

  erb :delete, :layout => :boilerplate
end



get "/product_form" do
  erb :product_form, :layout => :boilerplate
end

get "/product" do 
  p1 = Product.new("name" => "#{params["name"]}", 
  "description" => "#{params["description"]}", "cost" => "#{params["cost"]}", 
  "serial" => "#{params["serial"]}", "quantity" => "#{params["quantity"]}", 
  "location_id" => "#{params["location_id"]}", 
  "category_id" => "#{params["category_id"]}")  
  p1.insert  
  logger.info params
  @name = "#{params["name"]}"
  @description = "#{params["description"]}"
  @cost = "#{params["cost"]}"
  @serial = "#{params["serial"]}"
  @quantity = "#{params["quantity"]}"
  @location_id = "#{params["location_id"]}"
  @category_id = "#{params["category_id"]}"
  erb :product, :layout => :boilerplate
end

