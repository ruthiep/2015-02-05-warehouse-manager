# Class: Location
#
# Stores the warehouse locations for the products.
#
# Attributes:
# @id                - Integer: The id number of the Object.
# @name              - String: The name of the Object. 
#
#
# Public Methods:
# .delete_record
# #
# 

class Location
  include DatabaseMethods
  extend ClassMethods
  attr_reader :id
  attr_accessor :name
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
  end
  
 # Public: .delete_record
 # Deletes a location only if it is empty.
 #
 # Parameters:
 # id_to_remove           - Integer: The id of the location to delete.
 #
 # Returns:
 # nil
 #
 # State Changes:
 # Entry deleted from locations table.
   
  def self.delete_record(id_to_remove)
    if DATABASE.execute("SELECT id FROM products WHERE location_id = #{id_to_remove}") == []
    DATABASE.execute("DELETE FROM locations WHERE #{id_to_remove} = id")
    end
  end
    
end#classend