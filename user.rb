require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"
# This class performs functions related to adding and viewing elements from the users table in the saints database.
class User
  extend DatabaseClassMethod
  include DatabaseInstanceMethod
  
  attr_accessor :id, :user_name
  # Creates a User object with attributes: id and user_name.
  def initialize(values = {})
    @id = values["id"]
    @user_name = values["user_name"]
  end
  
end