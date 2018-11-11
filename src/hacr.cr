require "option_parser"

require "./hue"
require "./hue_resource"
require "./group"
require "./light"
require "./rule"
require "./sensor"
require "./context"
require "./cli_table"
require "./commands"

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

  def run
    command = options.shift
    command ||= ""
    case command
    when ""
      puts USAGE
      exit
    when .starts_with?("help")
      puts USAGE
      exit
    when .starts_with?("version")
      puts VERSION
      exit
    when .starts_with?("list")
      parse_list_command
    else
      puts "unknown command #{command}"
    end
  end

  def self.run(args)
    new(args).run
  end
  
  private def parse_list_command
    repeat_forever = false
    repeat_count = 1
    show_headers = true
    OptionParser.parse(options) do |parser|
      parser.on("-r", "--repeat", "Repeat LIST command continuously") do
        repeat_count = 99999999999
        show_headers = false
      end
      parser.on("-c COUNT", "--count=COUNT", "How often to repeat before exiting") do |rep| 
        repeat_count = rep.to_i
        show_headers = false
      end
      parser.on("-h", "--help", "Show help for options on LIST command") do
        puts parser
        repeat_count = 0
      end
    end
    Commands.do_list_command(repeat_count, 3600, show_headers, list_headers, column_widths)
  end

  def list_headers
    ["timestamp", "id", "name", "on", "detail"]
  end

  def column_widths
    [10, 5, 24, 12, -30]
  end

end

Hacr.run(ARGV)
