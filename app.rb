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
answer3 = 0

while answer1 != 4
  puts "What would you like to work on? (Please enter the number corresponding to your choice)"
  puts initial_array
  answer1 = gets.chomp.to_i
  
  # Loop for Saint countries
  if answer1 == 1
    country_array = ['1-See a list of countries in the database', '2-Add a country', '3-Update information for a country', '4-See a list of saints from a country', '5-Exit Countries']
    while answer2 != 5
      puts "What would you like to do in Saint Countries? (Please enter the number corresponding to your choice)"
      puts country_array
      answer2 = gets.chomp.to_i
      if answer2 == 1
        puts "Here's a list of countries."
        countries_array = Country.all
        countries_array.each do|x|
          puts "#{x["id"]} - #{x["country_name"]}"
        end
        
      elsif answer2 == 2
        puts "What is the name of the country you would like to add?"
        name = gets.chomp
        puts "Please write a short description for this country."
        description = gets.chomp
        Country.add(name, description)
        
      elsif answer2 == 3
        puts "What country would you like to update information for? (Please enter the number corresponding to your choice)"
        countries_array = Country.all
        countries_array.each do|x|
          puts "#{x["id"]} - #{x["country_name"]}"
        end
        country_id = gets.chomp.to_i
        country = Country.new(country_id)
        while answer3 != 3
          puts "Would you like to update the 1-Name, 2-Description, or 3-Exit? (Please enter the number corresponding to your choice)"
          answer3 = gets.chomp.to_i
          if answer3 == 1
            puts "What would you like to change the name of the country to?"
            name = gets.chomp
            country.update_names(name)
          elsif answer3 == 2
            puts "What would you like to change the description of the country to?"
            description = gets.chomp
            country.update_descriptions(description)
          elsif answer3 == 3
            break
          else
            puts "Invalid entry.  Please enter either 1, 2, or 3."
          end
        end
        
      elsif answer2 == 4
        puts "What country would you like to see a list of saints for? (Please enter the number corresponding to your choice)"
        puts "Here's a list of countries."
        countries_array = Country.all
        countries_array.each do|x|
          puts "#{x["id"]} - #{x["country_name"]}"
        end
        country_id = gets.chomp.to_i
        puts "Here's the list"
        saint_array = Saint.where_country(country_id)
        saint_array.each do |x|
          puts x["saint_name"]
        end
        
      elsif answer2 == 5
        break
      else
        puts "Invalid entry.  Please enter a number from 1 to 5."
      end
      answer3 = 0
    end
  
  # Loop for Saint categories  
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
          puts "#{x["id"]} - #{x["category_name"]}"
        end
        
      elsif answer2 == 2
        puts "What is the name of the category you would like to add?"
        cat = gets.chomp
        Category.add(cat)
        
      elsif answer2 == 3
        puts "What category would you like to see a list of saints for? (Please enter the number corresponding to your choice)"
        categories_array = Category.all
        categories_array.each do |x|
          puts "#{x["id"]} - #{x["category_name"]}"
        end
        cat_id = gets.chomp.to_i
        puts "Here's the list"
        saint_array = Saint.where_category(cat_id)
        saint_array.each do|x|
          puts x["saint_name"]
        end
        
      elsif answer2 == 4
        break
      else
        puts "Invalid entry.  Please enter a number from 1 to 4."
      end
      answer3 = 0
    end
  
  # Loop for individual Saints  
  elsif answer1 == 3
    saints_array = ['1-See a list of saints', '2-Add a saint', '3-See information on a particular saint', '4-Update information on a particular saint', '5-Exit Saints']
    while answer2 !=5
      puts "What would you like to do in Individual Saints? (Please enter the number corresponding to your choice)"
      puts saints_array
      answer2 = gets.chomp.to_i
      if answer2 == 1
        puts "Here's a list of saints."
        saint_array = Saint.all
        saint_array.each do |x|
          puts "#{x["id"]} - #{x["saint_name"]}"
        end
        
      elsif answer2 == 2
        puts "What is the name of the saint you would like to add?"
        name = gets.chomp
        puts "What year was this saint canonzied in (if known)?"
        year = gets.chomp.to_i
        puts "Please write a short description of this saint."
        description = gets.chomp
        puts "What country is this saint from? (Please enter the number corresponding to your choice)"
        countries_array = Country.all
        countries_array.each do|x|
          puts "#{x["id"]} - #{x["country_name"]}"
        end
        country_id = gets.chomp.to_i
        puts "What category is this saint in? (Please enter the number corresponding to your choice)"
        categories_array = Category.all
        categories_array.each do |x|
          puts "#{x["id"]} - #{x["category_name"]}"
        end
        cat_id = gets.chomp.to_i
        country = Country.new(country_id)
        country.new_saint(name, year, description, cat_id)
        
      elsif answer2 == 3
        puts "What saint would you like to see information on? (Please enter the number corresponding to your choice)"
        saint_array = Saint.all
        saint_array.each do |x|
          puts "#{x["id"]} - #{x["saint_name"]}"
        end
        saint_id = gets.chomp.to_i
        saint = Saint.new(saint_id)
        info_array = saint.get_infos
        puts "Would you like to see this saint's 1-Description, 2-Category, 3-Country? (Please enter the number corresponding to your choice)"
        answer3 = gets.chomp.to_i
        if answer3 == 1
          puts info_array.first["description"]
        elsif answer3 == 2
          puts info_array.first["category_id"]
        elsif answer3 == 3
          puts info_array.first["country_id"]
        else
          puts "Invalid entry.  Please enter a number from 1 to 3."
        end
        
      elsif answer2 == 4
        puts "What saint would you like to update information for? (Please enter the number corresponding to your choice)"
        saint_array = Saint.all
        saint_array.each do |x|
          puts "#{x["id"]} - #{x["saint_name"]}"
        end
        saint_id = gets.chomp.to_i
        saint = Saint.new(saint_id)
        puts "Would you like to update 1-Name, 2-Canonization Year, 3-Description, 4-Category, 5-Country? (Please enter the number corresponding to your choice)"
        answer3 = gets.chomp.to_i
        if answer3 == 1
          puts "What would you like to update the name to?"
          name = gets.chomp
          saint.update_names(name)
        elsif answer3 == 2
          puts "What would you like to update the canonization yeaer to?"
          year = get.chomp.to_i
          saint.update_canonization_years(year)
        elsif answer3 == 3
          puts "What would you like to update the description to?"
          description = gets.chomp
          saint.update_descriptions(description)
        elsif answer3 == 4
          puts "What category would you like to move the saint to? (Please enter the number corresponding to your choice)"
          categories_array = Category.all
          categories_array.each do |x|
            puts "#{x["id"]} - #{x["category_name"]}"
          end
          cat_id = gets.chomp.to_i
          saint.update_categories(cat_id)
        elsif answer3 == 5
          puts "What country would you like to move the saint to? (Please enter the number corresponding to your choice)"
          countries_array = Country.all
          countries_array.each do|x|
            puts "#{x["id"]} - #{x["country_name"]}"
          end
          country_id = gets.chomp.to_i
          saint.update_countries(country_id)
        else
          "Invlaid entry.  Please enter a number from 1 to 5."
        end
          
      elsif answer2 == 5
        break
      else
        puts "Invalid entry.  Please enter a number from 1 to 5."
      end
      answer3 = 0
    end
      
  elsif answer1 == 4
    break
    
  else
    puts "Invalid entry.  Please enter a number from 1 to 4."
  end
  answer2 = 0
end
    
  

