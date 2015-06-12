# This class performs functions related to adding, updating, and deleting elements from the saints table in the saints database.
def Saint
  # Creates an instance location allowing access to information about a certain saint.
  def initialize(id)
    @s_id = id
  end
  
  # Gets a list of saints with same category
  #
  # category_id - int value for a certain category type
  #
  # Returns an array of saints that match the given category_id
  def self.get_saints_by_category(category_id)
    CONNECTED.execute("SELECT * FROM 'saints' WHERE category_id = ?;", category_id)
  end
  
  # Gets a list of saints for a certain country
  # 
  # country_id - int value for a certain country
  #
  # Returns an array of saints that match the given country_id
  def self.get_saints_by_country(country_id)
    CONNECTED.execute("SELECT * FROM 'saints' WHERE country_id = ?;", country_id)
  end
  
  # Gets a full set of information on a saint
  #
  # Returns an array with that information
  def get_info
    CONNECTION.execute("SELECT * FROM 'saints' WHERE id = ?;", @s_id)
  end
  
  # Gets specific information on a saint based on a fields value
  #
  # field_value - string based on calling method
  #
  # Returns a string or int based on field value
  def get_field_value(field_value)
    result = CONNECTION.execute("SELECT ? FROM 'saints' WHERE id = ?;", field_value, @s_id)
    result.first[field_value]
  end
  
  def get_name
    get_field_value("saint_name")
  end
  
  def get_canonization_date
    get_field_value("canonization_date")
  end
  
  def get_description
    get_field_value("description")
  end
  
  def get_category_id
    get_field_value("category_id")
  end
  
  def get_country_id
    get_field_value("country_id")
  end
  
  # Updates specific information on a saint based on a fields value
  #
  # field_value - string based on calling method
  # value - string or int based on calling method
  #
  # Returns a new value in the table for the specified field.
  def update_field_value(field_value, value)
    CONNECTED.execute("UPDATE 'saints' SET ? = ? WHERE id = ?;", field_value, value, @s_id)
  end
  
  # name - string for the new name
  def update_name(name)
    update_field_value("saint_name", name)
  end
  
  # date - string for the new date
  def update_canonization_date(date)
    update_field_value("canonization_date", date)
  end
  
  # description - string for the new description
  def update_description(description)
    update_field_value("description", description)
  end
  
  # id - int for the new id 
  def update_category_id(id)
    update_field_value("category_id", id)
  end
  
  # id - int for the new id
  def update_country_id(id)
    update_field_value("country_id", id)
  end
  
  # Deletes a saint from the saints table
  def delete_saint
    CONNECTED.execute("DELETE FROM 'saints' WHERE id = ?;", @s_id)
  end
    
end