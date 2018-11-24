class Commands
  def self.do_list_command(repeat_count, sleep_time, show_headers)
    while (repeat_count > 0)
      data = get_hue_status.all_a fields
      render_as_table(fields, data, headers, column_widths, [] of String, show_headers)
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
    data = resources.map { |res| res.array(fields) }
    render_as_table(fields, data, headers, column_widths, details, show_headers)
  end

  def self.get_hue_status
    context = Context.new
    context.set_property("hue_state", Hue.bridge_state)
    Hue.new(context)
  end

  def self.render_as_table(field_names, data, column_headers, column_widths, detail_labels, show_headers)
    table = Report.new(DataFrame.new(field_names, data))
    table.show_headers = show_headers
    table.column_widths = column_widths
    table.column_headers = column_headers
    table.detail_labels = detail_labels
    Out.p table.render
  end

  def self.fields
    ["timestamp", "id", "name", "on", "detail", "conditions", "actions"]
  end

  def self.headers
    ["timestamp", "id", "name", "on"]
  end

  def self.details
    ["conditions", "actions"]
  end

  def self.column_widths
    [10, 5, 24, 12]
  end
end
