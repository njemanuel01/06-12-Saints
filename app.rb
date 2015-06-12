require "sqlite3"
require_relative "location.rb"
require_relative "category.rb"
require_relative "saints.rb"

CONNECTION = SQLite3::Database.new("saints.db")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'countries' (id INTEGER PRIMARY KEY, country_name TEXT, country_description TEXT)")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'categories' (id INTEGER PRIMARY KEY, category_name TEXT)")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS 'saints' (id INTEGER PRIMARY KEY, saint_name TEXT, 
canonization_date TEXT, description TEXT, category_id INTEGER, country_id INTEGER)")

CONNECTION.results_as_hash = true

