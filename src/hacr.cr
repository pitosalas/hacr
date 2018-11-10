require "./hue"
require "./hue_resource"
require "./group"
require "./light"
require "./rule"
require "./sensor"
require "./context"
require "./cli_table"

class Hacr

  USAGE = <<-USAGE
  Usage: hacr [command]
  Command:
      list                    show all home automation devices
      help                    show this help
      version                 show version
  USAGE

  VERSION = "0.1"

  def initialize(@options : Array(String))
  end

  private getter options
# @pitosalas your case is reversed: do case command; when .starts_with? "help" for example
  def run
    command = options.first?
    case
    when !command
      puts USAGE
      exit
    when "help".starts_with?(command)
      puts USAGE
      exit
    when "version".starts_with?(command)
      puts VERSION
      exit
    when "list".starts_with?(command)
      list_command
    else
      puts "unknown command #{command}"
    end
  end

  def self.run(args)
    new(args).run
  end
  
  def list_command
    context = Context.new
    context.set_property("hue_state", Hue.bridge_state)
    hue = Hue.new(context)
    table = CliTable.new
    table.headers = list_headers
    table.rows =  hue.all_a list_headers
    table.column_widths = column_widths
    puts table.render
  end

  def list_headers
    ["id", "name", "on", "detail"]
  end

  def column_widths
    [5, 22, 12, -30]
  end

end

Hacr.run(ARGV)
