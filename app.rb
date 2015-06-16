require "sqlite3"
require_relative "country.rb"
require_relative "category.rb"
require_relative "saint.rb"
require_relative "user.rb"
require_relative "change.rb"

CONNECTION = SQLite3::Database.new("saints.db")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'countries' (id INTEGER PRIMARY KEY, country_name TEXT UNIQUE NOT NULL, country_description TEXT NOT NULL)")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'categories' (id INTEGER PRIMARY KEY, category_name TEXT UNIQUE NOT NULL)")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'saints' (id INTEGER PRIMARY KEY, saint_name TEXT NOT NULL, 
canonization_year INTEGER, description TEXT NOT NULL, category_id INTEGER, country_id INTEGER)")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'users' (id INTEGER PRIMARY KEY, user_name TEXT)")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'changes' (id INTEGER PRIMARY KEY, change_description TEXT, user_id INTEGER)")

CONNECTION.results_as_hash = true

#--------------------------------------------------------------------------------------------
answer_array = ['Y', 'y', 'N', 'n']
initial_array = ['1-Saint Countries', '2-Saint Categories', '3-Individual Saints', '4-User Changes', '5-Quit']
answer1 = 0
answer2 = 0
answer3 = 0
count_array = []

puts "Would you like to create a new user? (Y/N)"
answer = gets.chomp

while !answer_array.include?(answer)
  puts "Invalid entry.  Please enter Y or N."
  answer = gets.chomp
end

if ((answer == 'Y') || (answer == 'y'))
  puts "What is your name?"
  name = gets.chomp
  user = User.add(name)
else
  puts "What user are you? (Please enter the number corresponding to your choice)"
  user_array = User.all
  user_array.each do |x|
    puts "#{x.id} - #{x.name}"
    count_array << x.id
  end
  user_id = gets.chomp.to_i
  while !count_array.include?(user_id)
    puts "Invalid entry. Please enter one of these numbers #{count_array}."
    user_id = gets.chomp.to_i
  end 
  user = User.find(user_id)
end  

count_array = []
while answer1 != 5
  puts "What would you like to work on? (Please enter the number corresponding to your choice)"
  puts initial_array
  answer1 = gets.chomp.to_i
  
  # Loop for Saint countries
  if answer1 == 1
    country_array = ['1-See a list of countries in the database', '2-Add a country', '3-Update information for a country', '4-See a list of saints from a country', '5-Delete a country','6-Exit Countries']
    while answer2 != 6
      puts "What would you like to do in Saint Countries? (Please enter the number corresponding to your choice)"
      puts country_array
      answer2 = gets.chomp.to_i
      if answer2 == 1
        puts "Here's a list of countries."
        countries_array = Country.all
        countries_array.each do|x|
          puts "#{x.id} - #{x.name}"
        end
        
      elsif answer2 == 2
        puts "What is the name of the country you would like to add?"
        name = gets.chomp
        puts "Please write a short description for this country."
        description = gets.chomp
        Country.add(name, description)
        user.add_change("Added #{name} to countries.")
        
      elsif answer2 == 3
        puts "What country would you like to update information for? (Please enter the number corresponding to your choice)"
        countries_array = Country.all
        countries_array.each do|x|
          puts "#{x.id} - #{x.name}"
          count_array << x.id
        end
        country_id = gets.chomp.to_i
        while !count_array.include?(country_id)
          puts "Invalid entry. Please enter one of these numbers #{count_array}."
          country_id = gets.chomp.to_i
        end
        country = Country.find(country_id)
        while answer3 != 3
          puts "Would you like to update the 1-Name, 2-Description, or 3-Exit? (Please enter the number corresponding to your choice)"
          answer3 = gets.chomp.to_i
          if answer3 == 1
            puts "What would you like to change the name of the country to?"
            name = gets.chomp
            country.name = name
            puts country.save
            user.add_change("#{name}'s name updated in countries.")
          elsif answer3 == 2
            puts "What would you like to change the description of the country to?"
            description = gets.chomp
            country.description = description
            puts country.save
            user.add_change("#{country.name}'s description updated in countries.")
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
          puts "#{x.id} - #{x.name}"
          count_array << x.id
        end
        country_id = gets.chomp.to_i
        while !count_array.include?(country_id)
          puts "Invalid entry. Please enter one of these numbers #{count_array}."
          country_id = gets.chomp.to_i
        end
        puts "Here's the list"
        saint_array = Saint.where_country(country_id)
        saint_array.each do |x|
          puts x.name
        end
        
      elsif answer2 == 5
        puts "What country would you like to delete, or 0-Exit? (Please enter the number corresponding to your choice)"
        countries_array = Country.all
        countries_array.each do |x|
          puts "#{x.id} - #{x.name}"
          count_array << x.id
        end
        country_id = gets.chomp.to_i
        if country_id == 0
          break
        end
        while !count_array.include?(country_id)
          puts "Invalid entry. Please enter one of these numbers #{count_array}."
          country_id = gets.chomp.to_i
        end
        if Saint.where_country(country_id) == []
          country = Country.find(country_id)
          name = country.name
          puts country.delete
          user.add_change("#{name} deleted from countries.")
        else
          puts "The country has saints associated with it, it cannot be deleted."
        end
        
      elsif answer2 == 6
        break
      else
        puts "Invalid entry.  Please enter a number from 1 to 5."
      end
      answer3 = 0
      count_array = []
    end
  
  # Loop for Saint categories  
  elsif answer1 == 2
    category_array = ['1-See a list of saint categories', '2-Add a saint category', '3-See a list of saints in a category', '4-Delete a category','5-Exit Categories']
    while answer2 != 5
      puts "What would you like to do in Saint Categories? (Please enter the number corresponding to your choice)"
      puts category_array
      answer2 = gets.chomp.to_i
      if answer2 == 1
        puts "Here's a list of saint categories."
        categories_array = Category.all
        categories_array.each do |x|
          puts "#{x.id} - #{x.name}"
        end
        
      elsif answer2 == 2
        puts "What is the name of the category you would like to add?"
        cat = gets.chomp
        Category.add(cat)
        user.add_change("Added #{cat} to categories.")
        
      elsif answer2 == 3
        puts "What category would you like to see a list of saints for? (Please enter the number corresponding to your choice)"
        categories_array = Category.all
        categories_array.each do |x|
          puts "#{x.id} - #{x.name}"
          count_array << x.id
        end
        cat_id = gets.chomp.to_i
        while !count_array.include?(cat_id)
          puts "Invalid entry. Please enter one of these numbers #{count_array}."
          cat_id = gets.chomp.to_i
        end
        puts "Here's the list"
        saint_array = Saint.where_category(cat_id)
        saint_array.each do|x|
          puts x.name
        end
        
      elsif answer2 == 4
        puts "What category would you like to delete or 0-Exit? (Please enter the number corresponding to your choice)"
        categories_array = Category.all
        categories_array.each do |x|
          puts "#{x.id} - #{x.name}"
          count_array << x.id
        end
        cat_id = gets.chomp.to_i
        if cat_id == 0
          break
        end
        while !count_array.include?(cat_id)
          puts "Invalid entry. Please enter one of these numbers #{count_array}."
          cat_id = gets.chomp.to_i
        end
        if Saint.where_category(cat_id) == []
          category = Category.find(cat_id)
          name = category.name
          puts category.delete
          user.add_change("#{name} deleted from categories.")
        else
          puts "The category has saints associated with it, it cannot be deleted."
        end
        
      elsif answer2 == 5
        break
      else
        puts "Invalid entry.  Please enter a number from 1 to 4."
      end
      answer3 = 0
      count_array = []
    end
  
  # Loop for individual Saints  
  elsif answer1 == 3
    saints_array = ['1-See a list of saints', '2-See a list of saints with a particular keyword in their description', '3-Add a saint', '4-See information on a particular saint', '5-Update information on a particular saint', '6-Delete a saint', '7-Exit Saints']
    while answer2 != 6
      puts "What would you like to do in Individual Saints? (Please enter the number corresponding to your choice)"
      puts saints_array
      answer2 = gets.chomp.to_i
      if answer2 == 1
        puts "Here's a list of saints."
        saint_array = Saint.all
        saint_array.each do |x|
          puts "#{x.id} - #{x.name}"
        end
        
      elsif answer2 ==2
        puts "What is the keyword you would like to search by? (please enter in all lowercase characters)"
        keyword = gets.chomp
        puts "Here's the list of saints with '#{keyword}' in their description."
        saint_array = Saint.where_keyword(keyword)
        if saint_array == []
          puts "No saints with that keyword in their description."
        else
          saint_array.each do |saint|
            puts saint.name
          end
        end
          
      elsif answer2 == 3
        puts "What is the name of the saint you would like to add?"
        name = gets.chomp
        puts "What year was this saint canonzied or beautified in (if known)?"
        year = gets.chomp.to_i
        puts "Please write a short description of this saint."
        description = gets.chomp
        puts "What country is this saint from? (Please enter the number corresponding to your choice)"
        countries_array = Country.all
        countries_array.each do|x|
          puts "#{x.id} - #{x.name}"
          count_array << x.id
        end
        country_id = gets.chomp.to_i
        while !count_array.include?(country_id)
          puts "Invalid entry. Please enter one of these numbers #{count_array}."
          country_id = gets.chomp.to_i
        end
        puts "What category is this saint in? (Please enter the number corresponding to your choice)"
        categories_array = Category.all
        categories_array.each do |x|
          puts "#{x.id} - #{x.name}"
          count_array << x.id
        end
        cat_id = gets.chomp.to_i
        while !count_array.include?(cat_id)
          puts "Invalid entry. Please enter one of these numbers #{count_array}."
          cat_id = gets.chomp.to_i
        end
        Saint.add(name, year, description, cat_id, country_id)
        user.add_change("Added #{name} to saints.")
        
      elsif answer2 == 4
        puts "What saint would you like to see information on? (Please enter the number corresponding to your choice)"
        saint_array = Saint.all
        saint_array.each do |x|
          puts "#{x.id} - #{x.name}"
          count_array << x.id
        end
        saint_id = gets.chomp.to_i
        while !count_array.include?(saint_id)
          puts "Invalid entry. Please enter one of these numbers #{count_array}."
          saint_id = gets.chomp.to_i
        end
        saint = Saint.find(saint_id)
        while answer3 != 4
          puts "Would you like to see this saint's 1-Description, 2-Category, 3-Country, 4-Exit? (Please enter the number corresponding to your choice)"
          answer3 = gets.chomp.to_i
          if answer3 == 1
            puts saint.description
          elsif answer3 == 2
            puts saint.category
          elsif answer3 == 3
            puts saint.country
          elsif answer3 == 4
            break
          else
            puts "Invalid entry.  Please enter a number from 1 to 4."
          end
        end
        
      elsif answer2 == 5
        puts "What saint would you like to update information for? (Please enter the number corresponding to your choice)"
        saint_array = Saint.all
        saint_array.each do |x|
          puts "#{x.id} - #{x.name}"
          count_array << x.id
        end
        saint_id = gets.chomp.to_i
        while !count_array.include?(saint_id)
          puts "Invalid entry. Please enter one of these numbers #{count_array}."
          saint_id = gets.chomp.to_i
        end
        saint = Saint.find(saint_id)
        while answer3 != 6
          puts "Would you like to update 1-Name, 2-Canonization Year, 3-Description, 4-Category, 5-Country, 6-Exit? (Please enter the number corresponding to your choice)"
          answer3 = gets.chomp.to_i
          if answer3 == 1
            puts "What would you like to update the name to?"
            saint.name = gets.chomp
            puts saint.save
            user.add_change("#{saint.name}'s name updated in saints.")
          elsif answer3 == 2
            puts "What would you like to update the canonization year to?"
            saint.year = gets.chomp.to_i
            puts saint.save
            user.add_change("#{saint.name}'s canonization year updated in saints.")
          elsif answer3 == 3
            puts "What would you like to update the description to?"
            saint.description = gets.chomp
            puts saint.save
            user.add_change("#{saint.name}'s description updated in saints.")
          elsif answer3 == 4
            puts "What category would you like to move the saint to? (Please enter the number corresponding to your choice)"
            categories_array = Category.all
            categories_array.each do |x|
              puts "#{x.id} - #{x.name}"
              count_array << x.id
            end
            cat_id = gets.chomp.to_i
            while !count_array.include?(cat_id)
              puts "Invalid entry. Please enter one of these numbers #{count_array}."
              cat_id = gets.chomp.to_i
            end
            saint.category_id = cat_id
            puts saint.save
            user.add_change("#{saint.name}'s category updated in saints.")
          elsif answer3 == 5
            puts "What country would you like to move the saint to? (Please enter the number corresponding to your choice)"
            countries_array = Country.all
            countries_array.each do|x|
              puts "#{x.id} - #{x.name}"
              count_array << x.id
            end
            country_id = gets.chomp.to_i
            while !count_array.include?(country_id)
              puts "Invalid entry. Please enter one of these numbers #{count_array}."
              country_id = gets.chomp.to_i
            end
            saint.country_id = country_id
            puts saint.save
            user.add_change("#{saint.name}'s country updated in saints.")
          elsif answer3 == 6
            break
          else
            "Invalid entry.  Please enter a number from 1 to 5."
          end
        end
          
      elsif answer2 == 6
        puts "What saint would you like to delete, or 0-Exit? (Please enter the number corresponding to your choice)"
        saint_array = Saint.all
        saint_array.each do |x|
          puts "#{x.id} - #{x.name}"
          count_array << x.id
        end
        saint_id = gets.chomp.to_i
        if saint_id == 0
          break
        end
        while !count_array.include?(saint_id)
          puts "Invalid entry. Please enter one of these numbers #{count_array}."
          saint_id = gets.chomp.to_i
        end
        saint = Saint.find(saint_id)
        name = saint.name
        puts saint.delete
        user.add_change("#{name} deleted from saints.")
        
      elsif answer2 == 7
        break
      else
        puts "Invalid entry.  Please enter a number from 1 to 5."
      end
      answer3 = 0
      count_array = []
    end
    
  elsif answer1 == 4
    while answer2 != 3
      puts "Would you like to see a list of 1-All changes, 2-Changes you have made, 3-Exit? (Please enter the number corresponding to your choice)"
      answer2 = gets.chomp.to_i
      if answer2 == 1
        puts "Here's a list of all changes."
        change_array = Change.all
        change_array.each do |x|
          puts "#{x.id} - #{x.description}"
        end   
      elsif answer2 == 2
        puts "Here's a list of your changes."
        change_array = Change.where_user(user.id)
        change_array.each do |x|
          puts "#{x.id} - #{x.description}"
        end  
      elsif answer2 == 3
        break
      else
        puts "Invalid entry.  Please enter a number from 1 to 3."
      end
    end
    
  elsif answer1 == 5
    break
    
  else
    puts "Invalid entry.  Please enter a number from 1 to 4."
  end
  answer2 = 0
end
    
  

