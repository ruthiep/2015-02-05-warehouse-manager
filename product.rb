
# Class: Product
#
# Tracks items in the grocery warehouse.
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
# #edit_record
# #save
# .find
# .search_where
# .delete_record
# #insert
# #
# 

class Product
  attr_reader :id
  attr_accessor :serial_number, :name, :description, :cost, :quantity,
   :location_id, :category_id
   
  def initialize(options)
    @serial_number = options["serial_number"]
    @name = options["name"]
    @description = options["description"]
    @cost = options["cost"]
    @quantity = options["quantity"]
    @location_id = options["location_id"]
    @category_id = options["category_id"]
    @id = options["id"]
  end
  
  # Public: #save
  # Saves the updated records.
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
  # Updates the records in the database.
    
  #make like save method
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

    DATABASE.execute("UPDATE products SET #{query_string} WHERE id = #{id}")
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
  
   
  def self.find(id_to_find)
    result = DATABASE.execute("SELECT * FROM products WHERE id = #{id_to_find}")
    record_details = result[0]
    self.new(record_details)
  end
  
  # Public: .search_where
  # Fetches items from the database based on the search criteria.
  #
  # Parameters:
  # search_for            - key(column) to search.
  # user_search           - The value to match.
  # search                - User_search formatted.
  # search_results        - Array: The search results based on the search_for                                  criteria.   
  # Returns: 
  # returns the search_results array.
  #
  # State changes:
  # none.
  
  #searches for products based on a user's selected field
  def self.search_where(search_for, user_search)
    search = nil
    if user_search.is_a?(Integer)
      search = user_search
    else search = "'#{user_search}'"
    end
      
    search_results = []
    results = DATABASE.execute("SELECT * FROM products WHERE #{search_for} = #{search}")
    results.each do |r|
      search_results << self.new(r)
    end
    search_results
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
  
  #shouldn't need much else.
  def self.delete_record(id_to_remove)
    DATABASE.execute("DELETE FROM products WHERE id = #{id_to_remove}")
  end
  
  def initialize(options)
    @serial_number = options["serial_number"]
    @name = options["name"]
    @description = options["description"]
    @cost = options["cost"]
    @quantity = options["quantity"]
    @location_id = options["location_id"]
    @category_id = options["category_id"]
    @id = options["id"]
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
    DATABASE.execute("INSERT INTO products (serial_number, name, description,
                                       cost, quantity, location_id, category_id)
                                        VALUES ('#{@serial_number}', '#{@name}',
                                         '#{@description}', #{@cost}, #{@quantity},
                                          #{@location_id}, #{@category_id})")
    @id = DATABASE.last_insert_row_id  
  end
  
end #classend

# attributes = []
# values = []
# instance_variables.each do |i|
#   attributes << i.to_s.delete("@")
# end
#
# attributes.each do |a|
#   value = self.send(a)
#
#   if value.is_a?(Integer)
#     values << "#{value}"
#   else values << "'#{value}'"
#   end
# end
#