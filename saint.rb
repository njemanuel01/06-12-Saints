# This class performs functions related to adding, updating, and deleting elements from the saints table in the saints database.
class Saint
  attr_accessor :id, :name, :year, :description, :category_id, :country_id
  # Creates a Saint object with attributes: id, name, year, description, category_id, and country_id.
  def initialize(id = nil, saint_name = nil, canonization_year = nil, description = nil, category_id = nil, country_id = nil)
    @id = id
    @name = saint_name
    @year = canonziation_year
    @description = description
    @category_id = category_id
    @country_id = country_id
  end
  
  # Creates a new saint for the country
  #
  # name - string for the saint's name
  # canonization_date - string for the date of canonization
  # description - string description of the saint
  # category_id - int value for the category a saint is in
  # country_id - int value for the country a saint is in
  # 
  # Returns a Saint object.
  def self.add(name, canonization_date, description, category_id, country_id)
    CONNECTION.execute("INSERT INTO 'saints' (saint_name, canonization_year, description, category_id, country_id) 
    VALUES (?, ?, ?, ?, ?);", name, canonization_date, description, category_id, country_id)
    id = CONNECTION.last_insert_row_id
    Saint.new(id, name, canonziation_year, description, category_id, country_id)
  end
  
  # Get a list of all the saints
  #
  # Returns an Array of Saint objects
  def self.all
    resut = CONNECTION.execute("SELECT * FROM saints;")
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << Saint.new(results_hash["id"], results_hash["saint_name"], results_hash["canonization_year"], results_hash["description"], results_hash["category_id"], results_hash["country_id"])
    end
    
    return results_as_objects
  end
  
  # Gets a list of saints with same category
  #
  # category_id - int value for a certain category type
  #
  # Returns an Array of Saint objects
  def self.where_category(category_id)
    results = CONNECTION.execute("SELECT saint_name FROM 'saints' WHERE category_id = ?;", category_id)
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << Saint.new(results_hash["id"], results_hash["saint_name"], results_hash["canonization_year"], results_hash["description"], results_hash["category_id"], results_hash["country_id"])
    end
    
    return results_as_objects
  end
  
  # Gets a list of saints with a particular keyword in the description.
  #
  # keyword - string value
  #
  # Return an Array of Student objects or string.
  def self.where_keyword(keyword)
    saint_array = []
    array = self.all
    array.each do |results_hash|
      string_array = x["description"].split
      if (string_array.include?(keyword) || string_array.include?(keyword.capitalize))
        saint_array << Saint.new(results_hash["id"], results_hash["saint_name"], results_hash["canonization_year"], results_hash["description"], results_hash["category_id"], results_hash["country_id"])
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
  # Returns an Array of Saint objects
  def self.where_country(country_id)
    results = CONNECTION.execute("SELECT saint_name FROM 'saints' WHERE country_id = ?;", country_id)
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << Saint.new(results_hash["id"], results_hash["saint_name"], results_hash["canonization_year"], results_hash["description"], results_hash["category_id"], results_hash["country_id"])
    end
    
    return results_as_objects
  end
  
  # Gets a full set of information on a saint
  #
  # Returns a Saint object
  def self.find(saint_id)
    @id = saint_id
    CONNECTION.execute("SELECT * FROM 'saints' WHERE id = ?;", @id)
    
    temp_name = result.first["user_name"]
    temp_year = result.first["canonization_year"]
    temp_description = result.first["description"]
    temp_category_id = result.first["category_id"]
    temp_country_id = result.first["country_id"]
    Saint.new(saint_id, temp_name, temp_year, temp_description, temp_category_id, temp_country_id)
  end
  
  # Updates specific information on a saint based on a fields value
  #
  # Returns a string.
  def save
    CONNECTION.execute("UPDATE 'saints' SET saint_name = ?, canonization_year = ?, description = ?, category_id = ?, country_id = ? WHERE id = ?;", @name, @year, @description, @category_id, @country_id, @id)
    "Saint saved."
  end
  
  # Deletes a saint from the saints table
  #
  # Returns a string
  def delete
    CONNECTION.execute("DELETE FROM 'saints' WHERE id = ?;", @id)
    "Saint deleted."
  end
  
  # Get the category name given a categories id
  #
  # Returns a string.  
  def category
    category = Category.find(@category_id)
    category.name
  end
    
  # Get the country name given a countries id
  #
  # Returns a string.
  def country
    country = Country.find(@country_id)
    country.name
  end
    
end