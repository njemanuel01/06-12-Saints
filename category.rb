class Category
  def initialize(id)
    @c_id = id
  end
  
  def get_category_id(category)
    result = CONNECTED.execute("SELECT id FROM categories WHERE category_name = ?;", category)
    result.first[id]
  end
  
end