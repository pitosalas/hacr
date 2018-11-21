class CliTable

  property detail_labels : Array(String) = [] of String
  property detail_data : Array(Array(String))
  property show_headers : Bool
  property row_headers : Array(String) = [] of String
  property rows : Array(Array(String)) = [] of Array(String)
  property column_widths : Array(Int32) = [] of Int32

  def initialize(show_headers)
    @detail_data = [] of Array(String)
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

  def row_headers
    @row_headers
  end

  def row_headers= (new_heads)
    @row_headers = new_heads
  end

  def column_widths= (new_widths)
    @column_widths = new_widths
  end

  def column_widths
    @column_widths
  end

  def render
    result = @show_headers ? header_render + "\n" : ""
    @rows.each_index do |index|
      result += row_render(@rows[index]) + "\n"
      result += detail_render(detail_labels, detail_data[index]) unless detail_labels.size == 0
    end
    result
  end

  def header_render
    result = ""
    @row_headers.each_index { |i| result += (" %#{column_widths[i]}s" % row_headers[i]) }
    result
  end

  def row_render(row)
    result = ""
    @row_headers.each_index { |i| result += (" %#{column_widths[i]}s" % format_value(row[i])) }
    result
  end

  def detail_render(label, data)
    result = ""
    label.each_index do |i|
      result += "    #{label[i]}: #{data[i]}\n"
    end
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