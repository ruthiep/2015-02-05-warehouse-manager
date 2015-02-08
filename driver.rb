require 'pry'
require 'sqlite3'
DATABASE = SQLite3::Database.new('warehouse_database.db')
require_relative "db_setup"
require_relative "database_methods"
require_relative 'location'
require_relative 'category'
require_relative "product"
require_relative "driver_methods"
include DriverMethods

#binding.pry

menu_prompt

input = ""
until input.downcase == "quit"
  puts "ENTER MENU SELECTION"
  input = gets.chomp

  case input
  when "1"
    submenu("LOCATION")
    sub_input = gets.chomp
    case sub_input
    when "1"
      add_location
    when "2"
      edit_location
    when "3"
      delete_location
    when "4"
      location_list
    else puts "RETURNING TO MAIN MENU"
    end
    
  when "2"
    submenu("PRODUCT")
    sub_input = gets.chomp
    case sub_input
    when "1"
      add_product
    when "2"
      edit_product
    when "3"
      delete_product
    when "4"
      product_list
      display_attributes
    else puts "RETURNING TO MAIN MENU"
    end
    
  when "3"
    submenu("CATEGORY")
    sub_input = gets.chomp
    case sub_input
    when "1"
      add_category
    when "2"
      edit_category
    when "3"
      delete_category
    when "4"
      category_list
    else puts "RETURNING TO MAIN MENU"
    end
    
  when "4"
    submenu("SEARCH")
    sub_input = gets.chomp
    case sub_input
    when "1"
      location_list
    when "2"
      product_list
    when "3"
      category_list
    else puts "RETURNING TO MAIN MENU"
    end
    
 else
   if input.downcase == "quit"
     puts "GOOD-BYE"
   else puts "INVALID INPUT, TRY AGAIN"
   end
 end
  menu_prompt 
end
