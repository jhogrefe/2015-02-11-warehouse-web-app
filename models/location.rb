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
  # None.
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
  # Updates the location name in the 'locations' table.
  #
  # Parameters:
  # instance_variables - value of each instance variable that is set by
  #                      the user.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Saves new value in 'locations' table in the database.
  def save
    get_location = []
    instance_variables.each do |x|
      get_location << x.to_s.delete("@")  
    end
    
    location_grabber = []   
    get_location.each do |y|
      local_var = self.send(y)
      if local_var.is_a?(Integer)
        location_grabber << "#{y} = #{local_var}"  
      else
        location_grabber << "#{y} = '#{local_var}'"
      end      
    end
    var = location_grabber.join(", ")
    DATABASE.execute("UPDATE locations SET #{var} WHERE id = #{id}")        
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
  # TRYING A REFACTOR USING A MODULE (NOT WORKING):
  # def delete
  #
  #   local_var = variable_loop(self.instance_variables)
  #
  #   DATABASE.execute("DELETE FROM locations WHERE id = #{local_var}")
  #
  # end
  
  
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