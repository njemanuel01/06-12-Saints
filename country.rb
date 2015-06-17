require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"
# This class performs functions related to adding, updating, and deleting elements from the countries table in the saints database.
class Country
  extend DatabaseClassMethod
  include DatabaseInstanceMethod
  
  attr_accessor :id, :name, :description, :errors
  # Creates an instance of the Country object.
  def initialize(values = {})
    @id = values["id"]
    @name = values["country_name"]
    @description = values["country_description"]
    @errors = []
  end
  
  # Adds a new country to the countries table
  #
  # Returns a Boolean.
  def add_to_database
    if self.valid?
      CONNECTION.execute("INSERT INTO countries (country_name, country_description) VALUES (?, ?);", @name, @description)
      @id = CONNECTION.last_insert_row_id
    else
      false
    end
  end
  
  # Checks to see if a country already exists in the table
  #
  # Returns a Boolean.
  def valid?
    array = self.class.all
    array.each do |country|
      if @name == country.name
        @errors << "This country already exists."
      end
    end
    
    return @errors.empty?
  end
  
  # Updates the information of a country in the table
  #
  # Returns a string.
  def save
    CONNECTION.execute("UPDATE 'countries' SET country_name = ?, country_description = ? WHERE id = ?;", @name, @description, @id)
    "Country saved."
  end
   
end

  