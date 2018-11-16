class Commands

  def self.do_list_command(repeat_count, sleep_time, show_headers, list_headers, column_widths)
    while (repeat_count > 0)
      row_data = get_hue_status.all_a list_headers
      render_as_table(row_data, show_headers, list_headers, column_widths)
      sleep sleep_time if repeat_count > 1
      repeat_count -= 1
    end
  end
  
  def self.do_show(show_what, repeat_count, sleep_time, show_headers, list_headers, column_widths)
    hue = get_hue_status
    resources = hue.find(show_what)
    if resources.size == 0
      Out.p "Unknown Hue resource #{show_what}"
      return
    end
    row_data = resources.map { |res| res.array(list_headers)}
    render_as_table(row_data, show_headers, list_headers, column_widths)
  end

  def self.get_hue_status
    context = Context.new
    context.set_property("hue_state", Hue.bridge_state)
    Hue.new(context)
  end

  def self.render_as_table(row_data, show_headers, list_headers, column_widths)
    table = CliTable.new(show_headers) 
    table.headers = list_headers
    table.rows = row_data
    table.column_widths = column_widths
    Out.p table.render
  end


end
