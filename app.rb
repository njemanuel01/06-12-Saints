require "sqlite3"
require_relative "country.rb"
require_relative "category.rb"
require_relative "saint.rb"

CONNECTION = SQLite3::Database.new("saints.db")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'countries' (id INTEGER PRIMARY KEY, country_name TEXT, country_description TEXT)")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'categories' (id INTEGER PRIMARY KEY, category_name TEXT)")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'saints' (id INTEGER PRIMARY KEY, saint_name TEXT, 
canonization_year INTEGER, description TEXT, category_id INTEGER, country_id INTEGER)")

CONNECTION.results_as_hash = true

#--------------------------------------------------------------------------------------------

initial_array = ['1-Saint Countries', '2-Saint Categories', '3-Individual Saints', '4-Exit']
answer1 = 0

while answer1 != 4
  puts "What would you like to work on? (Please enter the number corresponding to your choice)"
  puts initial_array
  answer1 = gets.chomp.to_i
  if answer1 == 1
    
  elsif answer1 == 2
    category_array = ['1-See a list of saint categories', '2-Add a saint category', '3-See a list of saints in a category', '4-Exit']
    while answer2 !=4
      puts "What would you like to do in Saint Categories? (Please enter the number corresponding to your choice)"
      
    
  elsif answer1 == 3
    
  elsif answer1 == 4
    break
  else
    puts "Invalid entry.  Please enter a number from 1 to 4."
    answer1 == gets.chomp.to_i
  end
end
    
  

