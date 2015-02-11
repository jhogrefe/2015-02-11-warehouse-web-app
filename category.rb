class Category
  attr_reader :id
  attr_accessor :manufacturer
  
  def initialize(options)
    @manufacturer = options["manufacturer"]
    @id = options["id"]
  end
  
  #Method 'insert' adds a new table row to the categories table
  #the argument will come in as [:@id, :@manufacturer]
  def insert
    DATABASE.execute("INSERT INTO categories (manufacturer) 
                      VALUES ('#{@manufacturer}')")
    @id = DATABASE.last_insert_row_id
  end
  
  # save method finds the existing value for 
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
    end
    
    var = category_grabber.join(", ")
    
    DATABASE.execute("DELETE FROM categories WHERE manufacturer = '#{manufacturer}'")
  end
end