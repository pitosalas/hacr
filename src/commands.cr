class Commands
  def self.do_list_command(repeat_count, sleep_time, show_headers)
    while (repeat_count > 0)
      extract_data = get_hue_status.all_a selectors
      detail_labels = [] of String
      render_as_table(extract_data, [] of Array(String), show_headers, column_names, detail_labels, column_widths)
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
    extract_data = resources.map { |res| res.array(selectors) }
    extract_detail = resources.map { |res| res.array(details) }
    resources.map { |res| res.array(selectors) }
    render_as_table(extract_data, extract_detail, show_headers, column_names, details, column_widths)
  end

  def self.get_hue_status
    context = Context.new
    context.set_property("hue_state", Hue.bridge_state)
    Hue.new(context)
  end

  def self.render_as_table(row_data, detail_data, show_headers, headers, detail_labels, widths)
    table = CliTable.new(show_headers)
    table.row_headers = headers
    table.detail_data = detail_data
    table.detail_labels = detail_labels
    table.rows = row_data
    table.column_widths = widths
    Out.p table.render
  end

  def self.selectors
    ["timestamp", "id", "name", "on"]
  end

  def self.column_names
    ["timestamp", "id", "name", "on"]
  end

  def self.details
    ["conditions", "actions"]
  end

  def self.column_widths
    [10, 5, 24, 12]
  end
end
