require "active_support"
require "active_support/inflector"

module DatabaseInstanceMethod
  
  def get(field)
    table_name = self.class.to_s.pluralize.underscore
    
    result = CONNECTION.execute("SELECT * FROM '#{table_name}' WHERE id = ?;", @id).first
    result[field]
  end
  
  # Updates the information of a country in the table
  #
  # Returns a string.
  # def save
  #     table_name = self.class.to_s.pluralize.underscore
  #
  #     CONNECTION.execute("UPDATE '#{table_name}' SET country_name = ?, country_description = ? WHERE id = ?;", @name, @description, @id)
  #     "Country saved."
  #   end
  
  def delete
    table_name = self.class.to_s.pluralize.underscore
    
    CONNECTION.execute("DELETE FROM '#{table_name}' WHERE id = ?;", @id)
  end
  
end