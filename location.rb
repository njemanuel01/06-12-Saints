class Location
  def initialize(id)
    @l_id = id
  end
  
  
  def self.new(location_name, location_description)
    CONNECTION.execute("INSERT INTO 'countries' (country_name, country_description) VALUES (?, ?);", location_name,location_description)
  end
  
  def update_location_description(description)
    CONNECTION.execute("UPDATE 'countries' SET country_description = ? WHERE id = #{@l_id};", description)
  end
  
  def delete_location
    CONNECTION.execute("DELETE FROM 'countries' WHERE id = #{@l_id};")
  end
  
  def new_saint(name, canonization_date, description, category_id)
    CONNECTION.execute("INSERT INTO 'saints' (saint_name, canonization_date, description, category_id, country_id) 
    VALUES (?, ?, ?, ?, ?);", name, canonization_date, description, category_id, @l_id)
  end
  
  
end

  