def Saint
  def initialize(id)
    @s_id = id
  end
  
  def get_info
    CONNECTION.execute("SELECT * FROM 'saints' WHERE id = ?;", @s_id)
  end
  
  def get_field_value(field_value)
    CONNECTION.execute("SELECT ? FROM 'saints' WHERE id = ?;", field_value, @s_id)
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
  
  def get_category
    CONNECTED.execute("SELECT category_name FROM 'categories' WHERE id = ?;", get_field_value("category_id"))
  end
  
  def get_country
    CONNECTED.execute("SELECT country_name FROM 'countries' WHERE id = ?;", get_field_value("country_id"))
  end
  
  def self.get_saints_by_category(category_id)
    CONNECTED.execute("SELECT * FROM 'saints' WHERE category_id = ?;", category_id)
  end
  
  def self.get_saints_by_country(country_id)
    CONNECTED.execute"SELECT * FROM 'saints' WHERE country_id = ?;", country_id)
  end
  
  def update_field_value(field_value, value)
    CONNECTED.execute("UPDATE 'saints' SET ? = ? WHERE id = ?;", field_value, value, @s_id)
  end
  
  def update_name(name)
    update_field_value("saint_name", name)
  end
  
  def update_canonization_date(date)
    update_field_value("canonization_date", date)
  end
  
  def update_description(description)
    update_field_value("description", description)
  end
  
  def update_category_id(id)
    update_field_value("category_id", id)
  end
  
  def update_country_id(id)
    update_field_value("country_id", id)
  end
  
  def delete_saint
    CONNECTED.execute("DELETE FROM 'saints' WHERE id = ?;", @s_id)
  end
    
end