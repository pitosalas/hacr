#
# Represent a rectangular grid of data. Columns have names (@fields) and rows have the data (@rows)
#
class DataFrame
  property rows : Array(Array(String))
  property fields : Array(String)

  def initialize(field_names, row_data)
    @rows = row_data
    @fields = field_names
  end

# Get the value of field name for row row
  def get(name, row)
    column = fields.index(name)
    if column.nil?
      "bad index"
    else
      rows[row][column]
    end
  end

# Return a single row as an array of tuples, [name, data]
  def labeled_row(index)
    rows[index].map_with_index do |value, index|
      [fields[index], value]
    end
  end

# Check internal consistency
  def validate
    if rows.nil? || fields.nil? || rows.size == 0 ||
       fields.size == 0 || rows[0].size != fields.size
      raise "Invalid DataFrame"
    end
  end
end
