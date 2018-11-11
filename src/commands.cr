class Commands

  def self.do_list_command(repeat_count, show_headers, list_headers, column_widths)
    while (repeat_count > 0)
      context = Context.new
      context.set_property("hue_state", Hue.bridge_state)
      hue = Hue.new(context)
      table = CliTable.new(show_headers)
      table.headers = list_headers
      table.rows = hue.all_a list_headers
      table.column_widths = column_widths
      puts table.render
      sleep 10 if repeat_count > 1
      repeat_count -= 1
    end
  end
end
