class Location 
  attr_reader :id
  attr_accessor :location_name
  
  def initialize(options)
    @location_name = options["location_name"]
    @id = options["id"]
  end
  
  #Method 'insert' adds a new table row to the locations table
  #the argument will come in as [:@id, :@location_name]
  def insert
    DATABASE.execute("INSERT INTO locations (location_name) 
                      VALUES ('#{@location_name}')")
    @id = DATABASE.last_insert_row_id
  end
  
  # save method finds the existing value for 
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
  
  def delete
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
    
    DATABASE.execute("DELETE FROM locations WHERE location_name = '#{location_name}'")
  end
end