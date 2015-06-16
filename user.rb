# This class performs functions related to adding and viewing elements from the users table in the saints database.
class User
  attr_accessor :id, :name
  # Creates a User object with attributes: id and user_name.
  def initialize(id = nil, user_name = nil)
    @id = id
    @name = user_name
  end
  
  # Creates a new user row in the countries table.
  #
  # user_name - string for the country name
  #
  # Returns an object of the Uswer class.
  def self.add(user_name)
    CONNECTION.execute("INSERT INTO users (user_name) VALUES (?);", user_name)
    id = CONNECTION.last_insert_row_id
    User.new(id, user_name)
  end
  
  # Gets a list of all the users.
  #
  # Returns an Array of objects
  def self.all
    results = CONNECTION.execute("SELECT * FROM users")
    results_as_objects = []
    results.each do |results_hash|
      results_as_objects << User.new(results_hash["id"], results_hash["user_name"])
    end
    
    return results_as_objects
  end
  
  # Gets a full set of information on a user
  #
  # Returns an object of the User class
  def self.find(user_id)
    @id = user_id
    result = CONNECTION.execute("SELECT * FROM 'users' WHERE id = ?;", @id)
    
    temp_name = result.first["user_name"]
    User.new(user_id, temp_name)
  end
  
  # Creates a new change row in the changes table.
  #
  # category_name - string for the country name
  #
  # Returns a Change object.
  def add_change(description)
    CONNECTION.execute("INSERT INTO changes (change_description, user_id) VALUES (?, ?);", description, @id)
    id = CONNECTION.last_insert_row_id
    Change.new(id, description, @id)
  end
  
end