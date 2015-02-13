# Public: Category
# A class to get and insert, save and delete new records in the 'categories'
# table of the database.
#
# Attributes:
# @id, @manufacturer
#
# Methods:
# #insert, #save, #delete
class Category
  attr_reader :id
  attr_accessor :manufacturer
  
  def initialize(options)
    @manufacturer = options["manufacturer"]
    @id = options["id"]
  end
  
  # Public: #insert
  # Adds the category name to the 'categories' table as a new record and 
  # assigns an id.
  #
  # Parameters:
  # None.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Inserts values into 'categories' table in the database as a new category
  # record.
  def insert
    DATABASE.execute("INSERT INTO categories (manufacturer) 
                      VALUES ('#{@manufacturer}')")
    @id = DATABASE.last_insert_row_id
  end
  
  # Public: #save
  # Updates the category name in the 'categories' table.
  #
  # Parameters:
  # instance_variables - value of each instance variable that is set by
  #                      the user.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Saves new value in 'categories' table in the database.
  def save
    get_category = []
    instance_variables.each do |x|
      get_category << x.to_s.delete("@")  
    end
    
    category_grabber = []    
    get_category.each do |y|
      local_var = self.send(y)    
      if local_var.is_a?(Integer)
        category_grabber << "#{y} = #{local_var}"  
      else
        category_grabber << "#{y} = '#{local_var}'"
      end
    end
    
    var = category_grabber.join(", ")   
    DATABASE.execute("UPDATE categories SET #{var} WHERE id = #{id}")
  end

  # Public: #delete
  # Returns the current values in the database as an array and deletes the 
  # category record.
  #
  # Parameters:
  # instance_variables - value of each instance variable that is set by
  #                      the user.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Removes the category record from the database.  
  def delete
    get_category = []
    instance_variables.each do |x|
      get_category << x.to_s.delete("@")  
    end
    
    category_grabber = []    
    get_category.each do |y|
      local_var = self.send(y)    
      if local_var.is_a?(Integer)
        category_grabber << "#{y} = #{local_var}"  
      else
        category_grabber << "#{y} = '#{local_var}'"
      end
      DATABASE.execute("DELETE FROM categories WHERE id = '#{local_var}'")      
    end        
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
     results = DATABASE.execute("SELECT * FROM categories")   
     results_as_objects = []   
     results.each do |r|
       results_as_objects << self.new(r)
     end   
     results_as_objects
   end
    
end