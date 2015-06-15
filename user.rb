# This class performs functions related to adding and viewing elements from the users table in the saints database.
class User
  # Creates an instance location allowing access to information about a certain user.
  def initialize(id)
    @u_id = id
  end
  
  # Creates a new user row in the countries table.
  #
  # category_name - string for the country name
  #
  # Returns a string.
  def self.add(user_name)
    CONNECTION.execute("INSERT INTO users (user_name) VALUES (?);", user_name)
    "#{user_name} added."
  end
  
  # Gets a list of all the users.
  #
  # Returns an Array
  def self.all
    CONNECTION.execute("SELECT * FROM users")
  end
  
  # Gets a full set of information on a user
  #
  # Returns an Array with that information
  def get_infos
    CONNECTION.execute("SELECT * FROM 'users' WHERE id = ?;", @u_id)
  end
  
  # Creates a new change row in the changes table.
  #
  # category_name - string for the country name
  #
  # Returns a string.
  def add_change(description)
    CONNECTION.execute("INSERT INTO changes (change_description, user_id) VALUES (?, ?);", description, @u_id)
    "Change recorded."
  end
  
end