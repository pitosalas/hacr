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
require "./out"

class CliHacr
  property repeat_count : Int64
  property show_headers : Bool

  USAGE = <<-USAGE
  Usage: hacr [command]
  Command:
      list                    show all home automation devices
      help                    show this help
      version                 show version
      show                    show status of an individual device
  USAGE

  VERSION = "0.1"

  def initialize(@commands : Array(String))
    @repeat_count = 1
    @show_headers = true
  end

  private getter commands

  def self.run(args)
    new(args).run
  end

  def run
    handle_null_command(commands)
    handle_options(commands)
    handle_command(commands)
  end

  def is_command?(string)
    /\A\w+\z/ =~ string
  end

  def handle_null_command(options)
    if options.size == 0 || !is_command?(options[0])
      Out.p USAGE
    end
  end

  # Commands are <word> or <word> <param>
  def handle_command(command)
    command_word = command[0].downcase
    param = command.size == 2 ? command[1] : ""
    return unless is_command?(command_word)
    case command_word
    when .starts_with?("help")
      Out.p USAGE
    when .starts_with?("version")
      Out.p VERSION
    when .starts_with?("list")
      Commands.do_list_command(@repeat_count, 3600, @show_headers, list_headers, column_widths)
    when .starts_with?("show")
      if !is_command?(param)
        report_unknown_command(command)
      else
        Commands.do_show(param, @repeat_count, 3600, @show_headers, list_headers, column_widths)
      end      
    else
      report_unknown_command(command)
    end
  end

  def report_unknown_command(command)
    Out.p "Unknown command \"#{command.join(", ")}\""
  end

  def handle_options(commands)
    if is_command?(commands[0])
      commands = commands[1..-1]
    end
    OptionParser.parse(commands) do |parser|
      parser.on("-r", "--repeat", "Repeat LIST command continuously") do
        @repeat_count = 99999999999
        @show_headers = false
      end
      parser.on("-c COUNT", "--count=COUNT", "How often to repeat before exiting") do |rep|
        @repeat_count = rep.to_i64
        @show_headers = false
      end
      parser.on("-h", "--help", "Show help for options on LIST command") do
        @repeat_count = 0
      end
    end
  end

  def list_headers
    ["timestamp", "id", "name", "on", "detail"]
  end

  def column_widths
    [10, 5, 24, 12, -20]
  end
end
