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
  # New values as strings for the new category record.
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
  # name_to_update - String, new name of category record.
  # id_var         - Integer, ID of category to delete.
  #
  # Returns:
  # String, new value for manufacturer field in updated category record.
  #
  # State Changes:
  # Saves new value in 'categories' table in the database.
  def save(name_to_update, id_var)
    DATABASE.execute("UPDATE categories SET manufacturer = '#{name_to_update}' 
    WHERE id = '#{id_var}'")
  end

  # Public: #delete
  # Gets the id value and deletes the category record matching the id.
  #
  # Parameters:
  # id_to_delete - Integer, ID of category to delete.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Removes the category record from the database.  
  def delete(id_to_delete)
    DATABASE.execute("DELETE FROM categories WHERE id = '#{id_to_delete}'")              
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