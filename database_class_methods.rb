require "active_support"
require "active_support/inflector"

module DatabaseClassMethod
  
  def all
    table_name = self.to_s.pluralize.underscore
    
    results = CONNECTION.execute("SELECT * FROM #{table_name}")
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << self.new(results_hash)
    end
    
    return results_as_objects
  end
  
  def find(id)
    table_name = self.to_s.pluralize.underscore
    
    result = CONNECTION.execute("SELECT * FROM '#{table_name}' WHERE id = ?;", id).first
    
    self.new(result)
  end
  
  # Gets a list of saints with same category
  #
  # category_id - int value for a certain category type
  #
  # Returns an Array of Saint objects
  def where(column_name, value)
    table_name = self.to_s.pluralize.underscore
    results = CONNECTION.execute("SELECT * FROM #{table_name} WHERE #{column_name} = ?;", value)
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << self.new(results_hash)
    end
    
    return results_as_objects
  end
  
  def add(values = []) #values_hash = {}
      table_name = self.to_s.pluralize.underscore

      pst = CONNECTION.prepare "SELECT * FROM #{table_name}"

      columns = pst.columns
      # columns = values_hash.keys
      columns.delete_at(0)
      # values = values_hash.values
      
      CONNECTION.execute("INSERT INTO #{table_name} (#{columns.join ", "}) VALUES (#{values.to_s[1...-1]});")
      # columns.join ", ", values.join ", "

      id = CONNECTION.last_insert_row_id
      values.insert(0, id)
      columns.insert(0, "id")
      # values["id"] = id
      
      values = columns.zip(values).to_h
      
      self.new(values)
  end
  
end