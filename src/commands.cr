class Commands

  def self.do_list_command(repeat_count, sleep_time, show_headers)
    puts repeat_count
    puts sleep_time
    while (repeat_count > 0)
      row_data = get_hue_status.all_a list_headers
      render_as_table(row_data, show_headers, list_headers, column_widths)
      sleep sleep_time if repeat_count > 1
      repeat_count -= 1
    end
  end
  
  def self.do_show(show_what, repeat_count, sleep_time, show_headers)
    hue = get_hue_status
    resources = hue.find(show_what)
    if resources.size == 0
      Out.p "Unknown Hue resource #{show_what}"
      return
    end
    row_data = resources.map { |res| res.array(list_headers_detailed)}
    render_as_table(row_data, show_headers, list_headers_detailed, column_widths_detailed)
  end

  def self.get_hue_status
    context = Context.new
    context.set_property("hue_state", Hue.bridge_state)
    Hue.new(context)
  end

  def self.render_as_table(row_data, show_headers, headers, widths)
    table = CliTable.new(show_headers) 
    table.headers = headers
    table.rows = row_data
    table.column_widths = widths
    Out.p table.render
  end


  def self.list_headers_detailed
    ["timestamp", "id", "name", "on", "detail"]
  end

  def self.column_widths_detailed
    [10, 5, 24, 12, -20]
  end

  def self.list_headers
    ["timestamp", "id", "name", "on"]
  end

  def self.column_widths
    [10, 5, 24, 12]
  end

end
