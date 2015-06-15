# This class performs functions related to adding and viewing elements from the users table in the saints database.
class Change
  # Creates an instance location allowing access to information about a certain user.
  def initialize(id)
    @c_id = id
  end
  
  # Creates a new change row in the changes table.
  #
  # category_name - string for the country name
  #
  # Returns a string.
  def self.add(description, user_id)
    CONNECTION.execute("INSERT INTO changes (change_description, user_id) VALUES (?, ?);", description, user_id)
    "#{description} added."
  end
  
  # Gets a list of all the changes.
  #
  # Returns an Array
  def self.all
    CONNECTION.execute("SELECT * FROM changes")
  end
  
  # Gets a full set of information on a change
  #
  # Returns an Array with that information
  def get_infos
    CONNECTION.execute("SELECT * FROM 'changes' WHERE id = ?;", @c_id)
  end
  
end