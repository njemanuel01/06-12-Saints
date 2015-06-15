# This class performs functions related to adding, updating, and deleting elements from the countries table in the saints database.
class Country
  # Creates an instance location allowing access to information about a certain location.
  def initialize(id)
    @l_id = id
  end
  
  # Creates a new country row in the countries table.
  #
  # country_name - string for the country name
  # country_description - string for the country description
  #
  # Returns a string.
  def self.add(country_name, country_description)
    CONNECTION.execute("INSERT INTO countries (country_name, country_description) VALUES (?, ?);", country_name,country_description)
    "#{country_name} added."
  end
  
  # Get a list of all the countries
  #
  # Returns an Array
  def self.all
    CONNECTION.execute("SELECT * FROM countries;")
  end
  
  # Gets a full set of information on a country
  #
  # Returns an array with that information
  def get_infos
    CONNECTION.execute("SELECT * FROM 'countries' WHERE id = ?;", @l_id)
  end
  
  # Updates the name of a countries location
  #
  # name - string for the new name to be used
  #
  # Returns a string.
  def update_names(name)
    CONNECTION.execute("UPDATE 'countries' SET country_name = ? WHERE id = ?;", name, @l_id)
    "Name updated."
  end
  
  # Updates the description of a country
  #
  # description - string value for the new description to be used
  #
  # Returns a string.
  def update_descriptions(description)
    CONNECTION.execute("UPDATE 'countries' SET country_description = ? WHERE id = ?;", description, @l_id)
    "Description updated."
  end
  
  # Deletes a country from the countries tables
  #
  # Returns a string
  def delete
    CONNECTION.execute("DELETE FROM 'countries' WHERE id = ?;", @l_id)
    "Country Deleted"
  end
  
  # Creates a new saint for the country
  #
  # name - string for the saint's name
  # canonization_date - string for the date of canonization
  # description - string description of the saint
  # category_id - int value for the category a saint is in
  # 
  # Returns a string.
  def new_saint(name, canonization_date, description, category_id)
    CONNECTION.execute("INSERT INTO 'saints' (saint_name, canonization_year, description, category_id, country_id) 
    VALUES (?, ?, ?, ?, ?);", name, canonization_date, description, category_id, @l_id)
    "Saint added."
  end
   
end

  