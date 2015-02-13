module ConvertToString
  
  # Private: variable_loop
  # Gets the value of a specific object's instance variables.
  #
  # Parameters:
  # array - Array: an array of instance variables.
  #
  # Returns:
  # An array of the values of the instance variables, converted to either a 
  # string or integer. 
  
  def variable_loop(array)

    get_variable = []
    instance_variables.each do |x|
      get_variable << x.to_s.delete("@")  
    end
    
    product_grabber = []    
    get_product.each do |y|
      local_var = self.send(y)    
      if local_var.is_a?(Integer)
        variable_grabber << "#{y} = #{local_var}"  
      else
        variable_grabber << "#{y} = '#{local_var}'"
      end
    end
  end

end  