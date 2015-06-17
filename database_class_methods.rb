require "active_support"
require "active_support/inflector"

module DatabaseClassMethod
  
  def all_module
    table_name = self.to_s.pluralize.underscore
    
    results = CONNECTION.execute("SELECT * FROM #{table_name}")
    results_as_objects = []
    results.each do |results_hash|
      binding.pry
      results_as_objects << self.new(results_hash["id"], results_hash["category_name"])
    end
    
    return results_as_objects
  end
  
end