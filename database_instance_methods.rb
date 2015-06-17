require "active_support"
require "active_support/inflector"

module DatabaseInstanceMethod
  
  def get(field)
    table_name = self.class.to_s.pluralize.underscore
    
    result = CONNECTION.execute("SELECT * FROM '#{table_name}' WHERE id = ?;", @id).first
    result[field]
  end
  
end