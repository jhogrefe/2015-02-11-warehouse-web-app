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
  
  #Method 'insert' adds a new table row to the products table
  #the argument will come in as [name, location_id, category_id,
  #description, cost, serial, quantity]
  
  def insert
    
    
    DATABASE.execute("INSERT INTO products (name, location_id, category_id,
                      description, cost, serial, quantity) 
                      VALUES ('#{name}', #{location_id}, #{category_id}, 
                      '#{description}', #{cost}, '#{serial}', #{quantity})")
    @id = DATABASE.last_insert_row_id
  end
  
  # save method finds the existing value for a row and "updates" it.
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
  
  def delete
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
    
    DATABASE.execute("DELETE FROM products WHERE name = '#{name}'")
  end
  
  
  def self.fetch_product_record(number)
    results = DATABASE.execute("SELECT * FROM products WHERE id = 
                                #{number}")
    #results should only return one position in the array since we're 
    #only requesting one variable:

    return results[0]
  end
  
  #assign_product_location is used to move products to different locations
  def self.assign_product_location(existing_product_key, desired_location_id)
    x = existing_product_key
    y = desired_location_id
    # consider using part or all of the code below for the cli menu conditionals
    # location_catcher = []
    # new_fetch = Product.fetch_product_record(x)
    # location_catcher = new_fetch[0]
    # puts location_catcher
    
    DATABASE.execute("UPDATE products SET location_id = #{y} 
                      WHERE id = #{x}")
  end
  
  def self.assign_product_category(existing_product_key, desired_category_id)
    x = existing_product_key
    y = desired_category_id
    
    DATABASE.execute("UPDATE products SET category_id = #{y} 
                      WHERE id = #{x}")
  end
  
  def self.update_product_quantity(existing_product_key, desired_quantity)
    x = existing_product_key
    y = desired_quantity
    
    DATABASE.execute("UPDATE products SET quantity = #{y} 
                      WHERE id = #{x}")
  end
  
  def self.where_products_in_category(category_id)
    results = DATABASE.execute("SELECT * FROM products WHERE category_id = 
                                 #{category_id}")
                                 
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
  # def self.find(number)
  #   results = DATABASE.execute("SELECT * FROM products WHERE id =
  #                               #{number}")
  #   #results should only return one position in the array since we're
  #   #only requesting one variable:
  #
  #
  #
  #   return results[0]
  #   #self.new is a new class instance that will return an array containing
  #   #one record as a hash
  #   # record_details = results[0]
  #   # self.new("id" => "{record_details}")
  # end
end