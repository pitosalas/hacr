class CliTable

  @headers : Array(String)
  @rows : Array(Array(String))
  @column_widths : Array(Int32)
  @show_headers : Bool

  def initialize(show_headers)
    @headers = Array(String).new
    @rows = Array(Array(String)).new
    @column_widths = Array(Int32).new
    @show_headers = show_headers
  end

  def add(headers, rows)
    @headers = headers
    @rows = rows
  end

  def rows_count
    @rows.length
  end

  def rows
    @rows
  end

  def rows=(new_rows)
    @rows = new_rows
  end

  def headers
    @headers
  end

  def headers= (new_heads)
    @headers = new_heads
  end

  def column_widths= (new_widths)
    @column_widths = new_widths
  end

  def column_widths
    @column_widths
  end


  def render
    result = @show_headers ? header_render + "\n" : ""
    @rows.each do |row|
      result += row_render(row) + "\n"
    end
    result
  end

  def header_render
    result = ""
    @headers.each_index { |i| result += (" %#{column_widths[i]}s" % headers[i]) }
    result
  end

  def row_render(row)
    result = ""
    @headers.each_index { |i| result += (" %#{column_widths[i]}s" % format_value(row[i])) }
    result
  end

  def reset
    @rows = Array(String)
  end

  def format_value(val)
    if [true, false].includes? val
      val ? "Yes" : "No"
    elsif val.nil?
      val = "nil"
    end
    val
  end
end