require "sqlite3"

# We use a sqllite3 table with one record for the state:
# sqllite3 table: ha_state(name, value)
# Single record has name: "hue_state"
# 

class Context
  FILE_SPEC = "/Users/pitosalas/.file.db"
  SQLLITE_URL = "sqlite3://#{FILE_SPEC}"

  @db : DB::Database

  def initialize
    @db = create_or_open
    @db.query("select name, value from ha_store") do |rs|
      rs.each do
        prop = rs.read(String)
        value = rs.read(String)
      end
    end
  end

  def get_property(prop) : String
    value = "none"
    @db.query("select name, value from ha_store") do |rs|
      rs.each do
        if rs.read(String) == prop 
          value = rs.read(String)
        end
      end
    end
    value
  end

  def get_property_as_json(prop) : JSON::Any
    prop_json = get_property(prop)
    JSON.parse(prop_json)
  end


  def set_property(name, value)
    @db.exec("update ha_store set value = ? where name = ?", value, name)
  end

  def create_or_open
    db = DB.open SQLLITE_URL
    if (!db_exist?(db))
      puts "Creating #{FILE_SPEC}"
      db_create(db)
    end
    db
  end

  def db_exist?(db)
    db.query "SELECT name FROM sqlite_master WHERE type='table'" do |rs|
      rs.each do
        if(rs.read(String) =="ha_store") 
          return true
        end
      end
      return false
    end
  end

  def db_create(db)
    db.exec "create table ha_store (name text, value string)"
    db.exec "insert into ha_store values (?, ?)", "hue_state", ""
  end

  def db_delete
    File.delete(FILE_SPEC)
  end
end
