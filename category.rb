# This class performs functions related to adding, updating, and deleting elements from the categories table in the saints database.
class Category
  attr_accessor :id, :name
  # Creates a Category object with attributes: id and name.
  def initialize(category_id, category_name)
    @id = id
    @name = category_name
  end
  
  # Creates a new category row in the countries table.
  #
  # category_name - string for the country name
  #
  # Returns a Category object.
  def self.add(category_name)
    CONNECTION.execute("INSERT INTO categories (category_name) VALUES (?);", category_name)
    id = CONNECTION.last_insert_row_id
    Category.new(id, category_name)
  end
  
  # Gets a list of all the categories.
  #
  # Returns an Array of Category objects
  def self.all
    results = CONNECTION.execute("SELECT * FROM categories")
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << Category.new(results_hash["id"], results_hash["category_name"])
    end
    
    return results_as_objects
  end
  
  # Gets a full set of information on a category
  #
  # Returns a Category object.
  def self.find(category_id)
    @id = category_id
    CONNECTION.execute("SELECT * FROM 'categories' WHERE id = ?;", @id)
    temp_name = result["category_name"]
    Category.new(category_id, temp_name)
  end
  
  # Deletes a category from the countries tables
  #
  # Returns a string
  def delete
    CONNECTION.execute("DELETE FROM 'categories' WHERE id = ?;", @id)
    "Category Deleted"
  end
  
end