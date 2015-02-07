# Class: Location
#
# Stores the warehouse locations for the products.
#
# Attributes:
# @options         - Hash: stores the information about each product, including:
#  
# @serial_number   - The product number/sku for the item in the warehouse.
# @name            - The name of the product.
# @description     - A description of the product.
# @cost            - The price of the product
# @quantity        - The quantity on hand.
# @location_id     - The location in the warehouse where the product is kept.
# @category_id     - The category in the store to which the item belongs.
#
#
# Public Methods:
# #save
# .find
# .delete_record
# #insert
# #
# 

class Location
  attr_reader :id
  attr_accessor :name
  
  def initialize(options)
    @name = options["name"]
    @id = options["id"]
  end
  
  # Public: .find
  # Fetches items from the database based on the search criteria.
  #
  # Parameters:
  # id_to_find          - Integer: the id number to search for in the database.
  # result              - Array: an array to hold the search results.
  # record_details      - Array: an array to hold the first row of the results.
  #
  #
  # Returns:
  # returns the matching record for the specified ID.
  #
  # State changes:
  # none.
  
  def self.find(search_for, user_search)
    if user_search.is_a?(Integer)
      search = "#{user_search}"
    else search = "'#{user_search}'"
    result = DATABASE.execute("SELECT * FROM locations WHERE '#{search_for}' = #{search}")
    record_details = result[0]
    self.new(record_details)
    end
  end
      
  # Public: #save
  # Adds the  to the hash.
  #
  # Parameters:
  # attributes              - Array: an array for the column headings                                            (attributes).
  # query_components_array: - Array:  an array for the search values.
  # changed_item            - String: the old value in the record.
  #
  #
  # Returns:
  # nil
  #
  # State changes:
  # Updates values in the database.
      
  def save
    attributes = []

    # Example  [:@serial_number, :@name, :@description]
    instance_variables.each do |i|
      # Example  :@name
      attributes << i.to_s.delete("@") # "name"
    end
  
    query_components_array = []

    attributes.each do |a|
      value = self.send(a)

      if value.is_a?(Integer)
        query_components_array << "#{a} = #{value}"
      else
        query_components_array << "#{a} = '#{value}'"
      end
    end

    query_string = query_components_array.join(", ")

    DATABASE.execute("UPDATE locations SET #{query_string} WHERE id = #{id}")
  end
  
  # Public: .delete_records
  # Deletes item(s) from the database based on the search criteria.
  #
  # Parameters:
  # id_to_remove          - Integer: ID value of the rows to delete.
  # 
  #
  # Returns: 
  # none
  #
  # State changes:
  # Values are deleted from the database.
  
  def self.delete_record(id_to_remove)
    if DATABASE.execute("SELECT id FROM products WHERE location_id = #{id_to_remove}") == []
    DATABASE.execute("DELETE FROM locations WHERE #{id_to_remove} = id")
    end
  end
    
  # Public: insert
  # Inserts the updated items into the database.
  #
  # Parameters:
  # id_to_remove          - Integer: ID value of the rows to delete.
  # @serial_number        - String: The serial number of the entry.
  # @name                 - String: The name of the entry.
  # @description          - String: The description of the entry.
  # @cost                 - Integer: The cost of the entry.
  # @quantity             - Integer: The quantity of the entry.
  # @location_id          - Integer: The location_id of the entry.
  # @category_id          - Integer: The category_id of the entry.
  #
  # Returns: 
  # @id the primary key for the product key.
  #
  # State changes:
  # Selected values are updated in the database.  
    
  def insert
    # attributes = []
   #  values = []
   #      # Example  [:@name, :@age, :@hometown]
   #  instance_variables.each do |i|
   #        # Example  :@name
   #    attributes << i.to_s.delete("@") # "name"
   #  end
   #
   #  attributes.each do |a|
   #    value = self.send(a)
   #
   #    if value.is_a?(Integer)
   #      values << "#{value}"
   #    else values << "'#{value}'"
   #    end
   #  end
      
    DATABASE.execute("INSERT INTO locations (name) VALUES ('#{@name}')")
    @id = DATABASE.last_insert_row_id  
  end
    
  
end#classend