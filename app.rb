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

initial_array = ['1-Saint Countries', '2-Saint Categories', '3-Individual Saints', '4-Quit']
answer1 = 0
answer2 = 0

while answer1 != 4
  puts "What would you like to work on? (Please enter the number corresponding to your choice)"
  puts initial_array
  answer1 = gets.chomp.to_i
  
  if answer1 == 1
    country_array = ['1-See a list of countries in the database', '2-Add a country', '3-Update information for a country', '4-See a list of saints from a country', '5-Exit Countries']
    while answer2 != 5
      puts "What would you like to do in Saint Countries? (Please enter the number corresponding to your choice)"
      puts country_array
      answer2 = gets.chomp.to_i
      if answer2 == 1
        
      elsif answer2 == 2
        
      elsif answer2 == 3
        
      elsif answer2 == 4
        
      elsif answer2 == 5
        break
      else
        puts "Invalid entry.  Please enter a number from 1 to 5."
      end
    end
    
  elsif answer1 == 2
    category_array = ['1-See a list of saint categories', '2-Add a saint category', '3-See a list of saints in a category', '4-Exit Categories']
    while answer2 !=4
      puts "What would you like to do in Saint Categories? (Please enter the number corresponding to your choice)"
      puts category_array
      answer2 = gets.chomp.to_i
      if answer2 == 1
        puts "Here's a list of saint categories."
        categories_array = Category.all
        categories_array.each do |x|
          puts "#{[:id]} - #{[:category_name]}"
        end
        
      elsif answer2 == 2
        puts "What is the name of the category you would like to add?"
        cat = gets.chomp
        Category.add(cat)
        
      elsif answer2 == 3
        puts "What category would you like to see a list of saints for? (Please enter the number corresponding to your choice)"
        countries_array = Category.all
        countries_array.each do |x|
          puts "#{[:id]} - #{[:category_name]}"
        end
        cat = gets.chomp.to_i
        puts "Here's the list"
        puts Saint.where_category(cat)
        
      elsif answer2 == 4
        break
      else
        puts "Invalid entry.  Please enter a number from 1 to 4."
      end
    end
    
  elsif answer1 == 3
    saints_array = ['1-See a list of saints', '2-Add a saint', '3-See information on a particular saint', '4-Update information on a particular saint', '5-Exit Saints']
    while answer2 !=5
      puts "What would you like to do in Individual Saints? (Please enter the number corresponding to your choice)"
      puts saints_array
      answer2 = gets.chomp.to_i
      if answer2 == 1
        
      elsif answer2 == 2
        
      elsif answer2 == 3
        
      elsif answer2 == 4
        
      elsif answer2 == 5
        break
      else
        puts "Invalid entry.  Please enter a number from 1 to 5."
      end
    end
      
  elsif answer1 == 4
    break
    
  else
    puts "Invalid entry.  Please enter a number from 1 to 4."
  end
  answer2 = 0
end
    
  

