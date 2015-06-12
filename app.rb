require "sqlite3"
require_relative "location.rb"
require_relative "category.rb"
require_relative "saints.rb"

CONNECTION = SQLite3::Database.new("saints.db")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'countries' (id INTEGER PRIMARY KEY, country_name TEXT, country_description TEXT)")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'categories' (id INTEGER PRIMARY KEY, category_name TEXT)")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'saints' (id INTEGER PRIMARY KEY, saint_name TEXT, 
canonization_date TEXT, description TEXT, category_id INTEGER, country_id INTEGER)")

CONNECTION.results_as_hash = true

#--------------------------------------------------------------------------------------------

choices_array = ["1-Add a country", "2-Delete a country from the list", "3-Update a country's information", "4-Add a saint to a country", 
  "5-See information on a particular saint", "6-Update information on a particular saint", "7-See a list of saints for a particular country", 
  "8-See a list of saints of a particular category", "8-Delete a saint's record", "9-Quit"]
  
  
puts "Welcome to the Saint's database.  Please choose from the following (Be sure to enter the integer.)"
puts choices_array
  
choice = gets.chomp.to_i
  
while ((choice < 1) || (choice > 9))
  puts "Invalid entry.  Please enter a number between 1 and 9."
  choice = gets.chomp.to_i
end
  
while choice != 9
  if choice == 1
    puts "What is the name of the country you would like to add?"
    name = gets.chomp
    puts "Please enter a description for this country."
    description = gets.chomp
    Location.new_country(name, description)
    
  elsif choice == 2
    puts "Which country would you like to delete?"
    puts Location.list_of_countries
    name = gets.chomp
    
    while Location.list_of_countries.include?(name) == false
      puts "Invalid entry.  Please enter the name again."
      puts Location.list_of_countries
      name = gets.chomp
    end
    
    country = Location.new(name)
    
    if Saints.get_saints_by_country(country.id) != nil
      puts "You cannot delete this counry, it has saints associated with it."
    else
      country.delete_location
    end
    
  elsif choice == 3
    puts "What country would you like to update?"
    puts Location.list_of_countries
    name = gets.chomp
    
  end
    
  
  

