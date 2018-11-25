#
# Present data in requested format, as text, suitable for display on the commmand line.
#   depends on DataFrame for the representation of the data
#   returns the result as a text string
#
class Report
  property data_frame : DataFrame
  property column_headers = Array(String).new
  property column_widths = Array(Int32).new
  property detail_labels = Array(String).new
  property show_headers = true

  def initialize(df)
    @data_frame = df
  end

  def data_count
    @data_frame.length
  end

  def render
    result = show_headers && column_headers.size > 0 ? header_render + "\n" : ""
    data_frame.rows.each_index do |index|
      result += row_render(index) + "\n" if column_headers.size > 0
      result += detail_render(index) if detail_labels.size > 0
    end
    result
  end

  def header_render
    result = ""
    column_headers.each_index do |i|
      result += " %#{column_widths[i]}s" % column_headers[i]
    end
    result
  end

  def row_render(index)
    result = ""
    column_headers.each_index do |i|
      result += " %#{column_widths[i]}s" % format_value(data_frame.get(column_headers[i], index))
    end
    result
  end

  # For each name in `detail_labels`, render:
  #      name1: value of field called 'name1' of row_number in data_frame
  #      name2: value of field called 'name2' of row_number in data_frame
  def detail_render(row_number)
    result = ""
    detail_labels.each_index do |index|
      result += "%15s: %-80s\n" % [detail_labels[index], data_frame.get(detail_labels[index], row_number)]
    end
    result
  end

  def reset
    @data = Array(String)
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
