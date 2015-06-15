# This class performs functions related to adding, updating, and deleting elements from the saints table in the saints database.
class Saint
  # Creates an instance location allowing access to information about a certain saint.
  def initialize(id)
    @s_id = id
  end
  
  # Get a list of all the saints
  #
  # Returns an Array
  def self.all
    CONNECTION.execute("SELECT * FROM saints;")
  end
  
  # Gets a list of saints with same category
  #
  # category_id - int value for a certain category type
  #
  # Returns an Array of saints that match the given category_id
  def self.where_category(category_id)
    CONNECTION.execute("SELECT saint_name FROM 'saints' WHERE category_id = ?;", category_id)
  end
  
  # Gets a list of saints with a particular keyword in the description.
  #
  # keyword - string value
  #
  # Return an Array or string.
  def self.where_keyword(keyword)
    array = self.all
    array.each do |x|
      string_array = x[description].split
      if string_array.include?(keyword || keyword.capitalize)
        saint_array.push("#{x["id"]}-#{x["name"]}")
      end
    end
    if saint_array == []
      "No saints with that keyword in their description."
    else
      saint_array
    end
  end
  
  # Gets a list of saints for a certain country
  # 
  # country_id - int value for a certain country
  #
  # Returns an Array of saints that match the given country_id
  def self.where_country(country_id)
    CONNECTION.execute("SELECT saint_name FROM 'saints' WHERE country_id = ?;", country_id)
  end
  
  # Gets a full set of information on a saint
  #
  # Returns an Array with that information
  def get_infos
    CONNECTION.execute("SELECT * FROM 'saints' WHERE id = ?;", @s_id)
  end
  
  # Updates specific information on a saint based on a fields value
  #
  # field_value - string based on calling method
  # value - string or int based on calling method
  #
  # Returns a new value in the table for the specified field.
  def update_field_values(field_value, value)
    CONNECTION.execute("UPDATE 'saints' SET #{field_value} = ? WHERE id = ?;", value, @s_id)
  end
  
  # name - string for the new name
  #
  # Returns a string
  def update_names(name)
    update_field_values("saint_name", name)
    "Name updated."
  end
  
  # date - string for the new date
  #
  # Returns a string
  def update_canonization_years(year)
    update_field_values("canonization_year", year)
    "Year updated."
  end
  
  # description - string for the new description
  #
  # Returns a string.
  def update_descriptions(description)
    update_field_values("description", description)
    "Description updated."
  end
  
  # id - int for the new id 
  #
  # Returns a string.
  def update_category_ids(id)
    update_field_values("category_id", id)
    "Category updated."
  end
  
  # id - int for the new id
  #
  # Returns a string.
  def update_country_ids(id)
    update_field_values("country_id", id)
    "Country updated."
  end
  
  # Deletes a saint from the saints table
  #
  # Returns a string
  def delete
    CONNECTION.execute("DELETE FROM 'saints' WHERE id = ?;", @s_id)
    "Saint deleted."
  end
    
end