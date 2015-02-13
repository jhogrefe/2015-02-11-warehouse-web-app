# Public: Product
# A class to get and set values in the 'products' database table.
#
# Attributes:
# id, name, location_id, category_id, description, cost, serial, quantity.
#
# Methods:
# #insert, #save, #delete, #fetch_product_record
class Product
  attr_reader   :id
  attr_accessor :name, :location_id, :category_id, :description, 
                :cost, :serial, :quantity

  def initialize(options)
    @name        = options["name"]
    @id          = options["id"]
    @location_id = options["location_id"]
    @category_id = options["category_id"]
    @description = options["description"]
    @cost        = options["cost"]
    @serial      = options["serial"]
    @quantity    = options["quantity"]
  end
  
  # Public: #insert
  # Adds the object to the 'products' table as a new product record and 
  # assigns an id.
  #
  # Parameters:
  # None.
  #
  # Returns: Integer,
  #
  # State Changes:
  # Inserts values into 'products' table in the database as a new product
  # record.
  def insert    
    DATABASE.execute("INSERT INTO products (name, location_id, category_id,
                      description, cost, serial, quantity) 
                      VALUES ('#{name}', #{location_id}, #{category_id}, 
                      '#{description}', #{cost}, '#{serial}', #{quantity})")
    @id = DATABASE.last_insert_row_id
  end
  
  # Public: #save
  # Take all the attributes for this object and make sure those are the 
  # values in this object's corresponding row in the 'students' table.
  #
  # Parameters:
  # None.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Sets the new values in the database.
  def save
    get_product = []
    instance_variables.each do |x|
      get_product << x.to_s.delete("@")  
    end
    
    product_grabber = []    
    get_product.each do |y|
      local_var = self.send(y)    
      if local_var.is_a?(Integer)
        product_grabber << "#{y} = #{local_var}"  
      else
        product_grabber << "#{y} = '#{local_var}'"
      end
    end
    
    var = product_grabber.join(", ")    
    DATABASE.execute("UPDATE products SET #{var} WHERE id = #{id}")
  end

  # Public: #delete
  # Gets the name value and deletes the product record for any matching name 
  # given by the the user.
  #
  # Parameters:
  # name_to_delete - String, name of product to delete.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Removes the product record from the database.   
  def delete(name_to_delete)
    DATABASE.execute("DELETE FROM products WHERE id = '#{name_to_delete}'")      
  end
  
  # Not sure if I will use this yet...
  def self.update_product_quantity(existing_product_key, desired_quantity)
    x = existing_product_key
    y = desired_quantity   
    DATABASE.execute("UPDATE products SET quantity = #{y} 
                      WHERE id = #{x}")
  end

  # Not sure if I will use this yet...  
  def self.where_products_in_category(category_id)
    results = DATABASE.execute("SELECT * FROM products WHERE category_id = 
                                 #{category_id}")
    results
  end
  
  def self.where_products_in_location(location_id)
    results = DATABASE.execute("SELECT * FROM products WHERE location_id = 
                                 #{location_id}")
                                 
    #create an empty array to pass in each separate hash:
    # results_changed_to_objects = []
    # results_changed_to_objects = results

    # results.each do |database_hashes|
    # results_changed_to_objects << self.new(database_hashes)
    #
    # end
    # results_changed_to_objects
    results
  end

  # Public: .all
  # Class method that returns all records in the table
  #
  # Parameters:
  # None.
  #
  # Returns:
  # All table records as objects.
  #
  # State Changes:
  # None.
  def self.all
     results = DATABASE.execute("SELECT * FROM products")
     results_as_objects = []
     results.each do |r|
       results_as_objects << self.new(r)
     end
     results_as_objects
   end

end