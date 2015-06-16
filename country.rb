# This class performs functions related to adding, updating, and deleting elements from the countries table in the saints database.
class Country
  attr_accessor :id, :name, :description
  # Creates an instance of the Country object.
  def initialize(id = nil, country_name = nil, description = nil)
    @id = id
    @name = country_name
    @description = description
  end
  
  # Creates a new country row in the countries table.
  #
  # country_name - string for the country name
  # country_description - string for the country description
  #
  # Returns a Country object.
  def self.add(country_name, country_description)
    CONNECTION.execute("INSERT INTO countries (country_name, country_description) VALUES (?, ?);", country_name,country_description)
    "#{country_name} added."
    id = CONNECTION.last_insert_row_id
    Country.new(id, country_name, country_description)
  end
  
  # Get a list of all the countries
  #
  # Returns an Array of Country objects.
  def self.all
    results = CONNECTION.execute("SELECT * FROM countries;")
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << Country.new(results_hash["id"], results_hash["country_name"], results_hash["description"])
    end
    
    return results_as_objects
  end
  
  # Gets a full set of information on a country
  #
  # Returns a Country object
  def self.find(user_id)
    @id = user_id
    result = CONNECTION.execute("SELECT * FROM 'countries' WHERE id = ?;", @id)
    
    temp_name = result.first["user_name"]
    temp_description = result.first["country_description"]
    Country.new(user_id, temp_name, temp_description)
  end
  
  # Updates the name of a countries location
  #
  # name - string for the new name to be used
  #
  # Returns a string.
  def save
    CONNECTION.execute("UPDATE 'countries' SET country_name = ?, country_description = ? WHERE id = ?;", @name, @description, @id)
    "Country saved."
  end
  
  # Deletes a country from the countries tables
  #
  # Returns a string
  def delete
    CONNECTION.execute("DELETE FROM 'countries' WHERE id = ?;", @id)
    "Country Deleted"
  end
   
end

  