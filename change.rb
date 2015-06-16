# This class performs functions related to adding and viewing elements from the changes table in the saints database.
class Change
  attr_accessor = :id, :description, :user_id
  # Creates a Change object with attributes: id, description, and user_id.
  def initialize(id = nil, description = nil, user_id = nil)
    @id = id
    @description = description
    @user_id = user_id
  end
  
  # Gets a list of all the changes.
  #
  # Returns an Array of Change objects
  def self.all
    results = CONNECTION.execute("SELECT * FROM changes")
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << Change.new(results_hash["id"], results_hash["change_description"], results_hash["user_id"])
    end
    
    return results_as_objects
  end
  
  # Gets a list of changes with same user
  #
  # user_id - int value for a certain category type
  #
  # Returns an Array of Change objects
  def self.where_user
    results = CONNECTION.execute("SELECT * FROM 'changes' WHERE user_id = ?;", @id)
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << Change.new(results_hash["id"], results_hash["change_description"], results_hash["user_id"])
    end
    
    return results_as_objects
  end
  
  # Gets a full set of information on a change
  #
  # Returns a Change object
  def self.find(change_id)
    @id = change_id
    CONNECTION.execute("SELECT * FROM 'changes' WHERE id = ?;", @id)
    
    temp_description = result["change_description"]
    temp_user_id = result["user_id"]
    Change.new(change_id, temp_description, temp_user_id)
  end
  
end