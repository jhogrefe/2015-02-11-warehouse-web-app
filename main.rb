require 'pry'
require 'sinatra'
require 'sqlite3'
require_relative "models/modules.rb"

DATABASE = SQLite3::Database.new('database/warehouse.db')


require_relative "database/database_setup"
require_relative "models/category.rb"
require_relative "models/location.rb"
require_relative "models/product.rb"


get "/" do
  erb :home, :layout => :boilerplate 
end


get "/add_location" do
  erb :add_location, :layout => :boilerplate
end

get "/location" do
  l1 = Location.new(params)
  l1.insert
  @location_name = "#{params["location_name"]}"
  erb :location, :layout => :boilerplate
end


get "/update_location" do
  erb :update_location, :layout => :boilerplate
end

get "/location_update" do
  l3 = Location.new(params)
  l3.save("#{params["location_name"]}", "#{params["location_id"]}")
  @location_name = "#{params["location_name"]}"
  erb :locations_update, :layout => :boilerplate
end


get "/delete_location" do
  erb :delete_location, :layout => :boilerplate
end

get "/location_delete" do
  l2 = Location.new(params)
  l2.delete(params["location_id"])

  erb :delete, :layout => :boilerplate
end


get "/fetch_locations" do
  @locations = Location.all
  erb :fetch_locations, :layout => :boilerplate
end


get "/add_category" do
  erb :add_category, :layout => :boilerplate
end

get "/category" do
  c1 = Category.new(params)
  c1.insert
  @manufacturer = "#{params["manufacturer"]}"
  erb :category, :layout => :boilerplate
end


get "/update_category" do
  erb :update_category, :layout => :boilerplate
end

get "/category_update" do
  c3 = Category.new(params)
  c3.save("#{params["manufacturer"]}", "#{params["category_id"]}")
  @manufacturer = "#{params["manufacturer"]}"
  erb :category_update, :layout => :boilerplate
end


get "/delete_category" do
  erb :delete_category, :layout => :boilerplate
end

get "/category_delete" do
  c2 = Category.new(params)
  c2.delete(params["category_id"])
  erb :delete, :layout => :boilerplate
end


get "/fetch_categories" do
  @categories = Category.all
  erb :fetch_categories, :layout => :boilerplate
end


get "/product_form" do
  erb :product_form, :layout => :boilerplate
end

get "/product" do 
  p1 = Product.new(params)  
  p1.insert  
  @name = "#{params["name"]}"
  @description = "#{params["description"]}"
  @cost = "#{params["cost"]}"
  @serial = "#{params["serial"]}"
  @quantity = "#{params["quantity"]}"
  @location_id = "#{params["location_id"]}"
  @category_id = "#{params["category_id"]}"
  erb :product, :layout => :boilerplate
end


get "/delete_product" do
  erb :delete_product, :layout => :boilerplate
end

get "/product_delete" do
  p2 = Product.new(params)
  p2.delete(params["name"])
  erb :delete, :layout => :boilerplate
end


get "/fetch_products" do
  @products = Product.all
  erb :fetch_products, :layout => :boilerplate
end
