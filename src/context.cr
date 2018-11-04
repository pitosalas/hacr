require "sqlite3"

class Context
  FILE_SPEC = "/Users/pitosalas/.file.db"
  SQLLITE_URL = "sqlite3://#{FILE_SPEC}"

  # sqllite3 table: ha_state(property, value)
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
  end

  def db_delete
    File.delete(FILE_SPEC)
  end
end
