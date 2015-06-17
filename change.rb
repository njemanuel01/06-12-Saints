require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"
# This class performs functions related to adding and viewing elements from the changes table in the saints database.
class Change
  extend DatabaseClassMethod
  include DatabaseInstanceMethod
  
  attr_accessor :id, :description, :user_id
  # Creates a Change object with attributes: id, description, and user_id.
  def initialize(id = nil, description = nil, user_id = nil)
    @id = id
    @description = description
    @user_id = user_id
  end
  
  # Gets a list of changes with same user
  #
  # user_id - int value for a certain category type
  #
  # Returns an Array of Change objects
  def self.where_user(user_id)
    results = CONNECTION.execute("SELECT * FROM 'changes' WHERE user_id = ?;", user_id)
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << Change.new(results_hash["id"], results_hash["change_description"], results_hash["user_id"])
    end
    
    return results_as_objects
  end
  
end