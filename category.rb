# This class performs functions related to adding, updating, and deleting elements from the categories table in the saints database.
class Category
  # Creates an instance location allowing access to information about a certain category.
  def initialize(id)
    @c_id = id
  end
  
  # Gets the category_id for a certain category in the categories table.
  #
  # category - string value for the category
  #
  # Returns an integer for the category_id
  def get_category_ids(category)
    result = CONNECTED.execute("SELECT 'id' FROM 'categories' WHERE category_name = ?;", category)
    result.first["id"]
  end
  
end