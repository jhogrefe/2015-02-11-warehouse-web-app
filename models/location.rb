# Public: Location
# A class to get and insert, save and delete new records in the 'locations'
# table of the database.
#
# Attributes:
# @id, @location_name
#
# Methods:
# #insert, #save, #delete
class Location 
  
  attr_reader :id
  attr_accessor :location_name
  
  def initialize(options)
    @location_name = options["location_name"]
    @id = options["id"]
  end
  
  # Public: #insert
  # Adds the location name to the 'locations' table as a new record and 
  # assigns an id.
  #
  # Parameters:
  # None.
  #
  # Returns:
  # New values as strings for the new product record.
  #
  # State Changes:
  # Inserts values into 'locations' table in the database as a new location
  # record.
  def insert
    DATABASE.execute("INSERT INTO locations (location_name) 
                      VALUES ('#{@location_name}')")
    @id = DATABASE.last_insert_row_id
  end
  
  # Public: #save
  # Updates the location name in the 'categories' table.
  #
  # Parameters:
  # name_to_update - String, new name of location record.
  # id_var         - Integer, ID of location to delete.
  #
  # Returns:
  # String, new value for location_name field in updated location record.
  #
  # State Changes:
  # Saves new value in 'locations' table in the database.
  def save(name_to_update, id_var)
    DATABASE.execute("UPDATE locations SET location_name = '#{name_to_update}' 
    WHERE id = '#{id_var}'")        
  end

  # Public: #delete
  # Gets the id value and deletes the location record matching the id.
  #
  # Parameters:
  # id_to_delete - Integer, ID of location to delete.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Removes the location record from the database.   
  def delete(id_to_delete)
    DATABASE.execute("DELETE FROM locations WHERE id = '#{id_to_delete}'")
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
     results = DATABASE.execute("SELECT * FROM locations")   
     results_as_objects = []   
     results.each do |r|
       results_as_objects << self.new(r)
     end  
     results_as_objects
  end
  
end