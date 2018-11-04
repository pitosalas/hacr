require_relative 'cli_table'
require_relative 'hue'

# The 'hue' commmands
class HueCommand < Thor
  desc "list", "list Hue items"
  def list
    hue = Hue.new(context, Hue.bridge_state)
    table = CliTable.new
    table.headers = list_headers
    table.rows =  hue.all_a list_headers
    table.column_widths = column_widths
    puts table.render
  end

  desc "pair", "run pairing process to allow you to access the hue bridge"
  def pair
    Hue.new(context).pair
  end

  private

  def context
    Context.new
  end

  def list_headers
    ["id", "name", "on", "detail"]
  end

  def column_widths
    ["5", "22", "12", "-30"]
  end
end
