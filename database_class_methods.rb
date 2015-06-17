require "active_support"
require "active_support/inflector"

module DatabaseClassMethod
  
  def all_module
    table_name = self.to_s.pluralize.underscore
    
    results = CONNECTION.execute("SELECT * FROM #{table_name}")
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << self.new(results_hash)
    end
    
    return results_as_objects
  end
  
  def find_module(id)
    table_name = self.to_s.pluralize.underscore
    
    result = CONNECTION.execute("SELECT * FROM '#{table_name}' WHERE id = ?;", id).first
    
    self.new(result)
  end
  
  def add_module(values = [])
    table_name = self.to_s.pluralize.underscore
    
    pst = CONNECTION.prepare "SELECT * FROM #{table_name}"    
    
    columns = pst.columns
    columns.delete_at(0)
    
    CONNECTION.execute("INSERT INTO #{table_name} (#{columns.to_s.delete "\""}) VALUES (?);", values)
    
    id = CONNECTION.last_insert_row_id
    values.insert(0, id)
    values = columns.zip(values).to_h
    self.new(values)  
  end
  
end