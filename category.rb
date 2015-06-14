# This class performs functions related to adding, updating, and deleting elements from the categories table in the saints database.
class Category
  # Creates an instance location allowing access to information about a certain category.
  def initialize(id)
    @c_id = id
  end
  
  # Creates a new category row in the countries table.
  #
  # category_name - string for the country name
  #
  # Returns a string.
  def self.add(category_name)
    CONNECTION.execute("INSERT INTO categories (category_name) VALUES (?);", category_name)
    "#{category_name} added."
  end
  
  # Gets a list of all the categories.
  #
  # Returns an array
  def self.all
    CONNECTION.execute("SELECT * FROM categories")
  end
  
  # Gets a full set of information on a category
  #
  # Returns an array with that information
  def get_infos
    CONNECTION.execute("SELECT * FROM 'categories' WHERE id = ?;", @c_id)
  end
  
  # Deletes a category from the countries tables
  #
  # Returns a string
  def delete
    CONNECTION.execute("DELETE FROM 'categories' WHERE id = ?;", @c_id)
    "Category Deleted"
  end
  
end