require 'pry'
require 'db_setup'

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
# #
# #
# #
# #
# #
# 

class Product
  
  attr_reader :id, :serial_number, :name, :description, :cost, :quantity, :location_id, :category_id
  def initialize(options)
    @serial_number = options[:serial_number]
    @name = options[:name]
    @description = options[:name]
    @cost = options[:cost]
    @quantity = options[:quantity]
    @location_id = options[:location_id]
    @category_id = options[:category_id]
  end
   
  # Public: #edit_record
  # Adds members to the hash.
  #
  # Parameters:
  # changed_item    - String: the old value in the record.
  # column_name     - String: the column for the item to be updated.
  # new_value       - String: the new value to be updated.
  #
  #
  # Returns:
  # 
  #
  # State changes:
  # changes the value of the record in the database.
  
  def self.edit_record(changed_item, column_name, new_value)
    DATABASE.execute("UPDATE products SET '#{column_name}' = '#{new_value}' 
                      WHERE id = '#{changed_item}' ")
  end
  
  def save_record
      save
  end
   
  
  def self.delete_record(id_to_remove)
      DATABASE.execute("DELETE FROM products WHERE #{id_to_remove} = id")
  end
    
end

  private
  def insert
    attributes = []
        values = []
            # Example  [:@name, :@age, :@hometown]
        instance_variables.each do |i|
              # Example  :@name
          attributes << i.to_s.delete("@") # "name"
        end
        
        attributes.each do |a|
          value = self.send(a)
      
          if value.is_a?(Integer)
            values << "#{value}"
          else values << "'#{value}'"
          end
        end
    DATABASE.execute("INSERT INTO products (#{attributes.join(", ")}) VALUES
                       (#{values.join(", ")})")
    @id = DATABASE.last_insert_row_id  
end
  
end