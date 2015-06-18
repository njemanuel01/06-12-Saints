require "active_support"
require "active_support/inflector"

module DatabaseInstanceMethod
  
  def get(field)
    table_name = self.class.to_s.pluralize.underscore
    
    result = CONNECTION.execute("SELECT * FROM '#{table_name}' WHERE id = ?;", @id).first
    result[field]
  end
  
  def save
    table_name = self.class.to_s.pluralize.underscore
    value = self.to_s
    
    hash = {}
    self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
    hash.delete("id")
    hash.delete("errors")
    sql_hash = hash.to_s.delete "\>"

    CONNECTION.execute("UPDATE '#{table_name}' SET #{sql_hash[1...-1]} WHERE id = ?;", @id)
    "Saved."
  end
  
  def delete
    table_name = self.class.to_s.pluralize.underscore
    
    CONNECTION.execute("DELETE FROM '#{table_name}' WHERE id = ?;", @id)
    "Deleted."
  end
  
end