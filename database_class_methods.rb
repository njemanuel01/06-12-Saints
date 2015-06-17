require "active_support"
require "active_support/inflector"

module DatabaseClassMethod
  
  def all_module
    table_name = self.to_s.pluralize.underscore
    
    results = CONNECTION.execute("SELECT * FROM #{table_name}")
    results_as_objects = []
    results.each do |results_hash|
      values = results_hash.values
      results_as_objects << self.new(values)
    end
    
    return results_as_objects
  end
  
  def find_module(category_id)
    table_name = self.to_s.pluralize.underscore
    
    @id = category_id
    result = CONNECTION.execute("SELECT * FROM '#{table_name}' WHERE id = ?;", @id)
    values = results_hash.values
    
    self.new(values)
  end
  
  def add_module(category_name)
    # table_name = self.to_s.pluralize.underscore
    
    # CONNECTION.execute("INSERT INTO #{table_name} (Some column) VALUES (?);", category_name)
    
  end
  
  def delete(id)
    table_name = self.to_s.pluralize.underscore
    
    CONNECTION.execute("DELETE FROM '#{table_name}' WHERE id = ?;", id)
  end
  
  
end