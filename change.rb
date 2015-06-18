require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"
# This class performs functions related to adding and viewing elements from the changes table in the saints database.
class Change
  extend DatabaseClassMethod
  include DatabaseInstanceMethod
  
  attr_accessor :id, :change_description, :user_id
  # Creates a Change object with attributes: id, description, and user_id.
  def initialize(values = {})
    @id = values["id"]
    @change_description = values["change_description"]
    @user_id = values["user_id"]
  end
  
end