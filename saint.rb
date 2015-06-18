require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"
# This class performs functions related to adding, updating, and deleting elements from the saints table in the saints database.
class Saint
  extend DatabaseClassMethod
  include DatabaseInstanceMethod
  
  attr_accessor :id, :name, :year, :description, :category_id, :country_id
  # Creates a Saint object with attributes: id, name, year, description, category_id, and country_id.
  def initialize(values = {})
    @id = values["id"]
    @name = values["saint_name"]
    @year = values["canonization_year"]
    @description = values["description"]
    @category_id = values["category_id"]
    @country_id = values["country_id"]
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
      results_as_objects << Saint.new(results_hash)
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
    array.each do |saint|
      string_array = saint.description.split
      if (string_array.include?(keyword) || string_array.include?(keyword.capitalize))
        saint_array << saint
      end
    end
    
    return saint_array
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
      results_as_objects << Saint.new(results_hash)
    end
    
    return results_as_objects
  end
  
  # Updates the information of a saint in the table
  #
  # Returns a string.
  def save
    CONNECTION.execute("UPDATE 'saints' SET saint_name = ?, canonization_year = ?, description = ?, category_id = ?, country_id = ? WHERE id = ?;", @name, @year, @description, @category_id, @country_id, @id)
    "Saint saved."
  end
    
end