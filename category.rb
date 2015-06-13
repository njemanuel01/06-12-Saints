# This class performs functions related to adding, updating, and deleting elements from the categories table in the saints database.
class Category
  # Creates an instance location allowing access to information about a certain category.
  def initialize(id)
    @c_id = id
  end
  
  # Gets a list of all the categories.
  #
  # Returns an array
  def self.all
    CONNECTION.execute("SELECT * FROM categories")
  end
  
end