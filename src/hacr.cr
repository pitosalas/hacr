require "./cli_hacr"

<<<<<<< HEAD
# Rub top level cli
CliHacr.run(ARGV)
=======
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

class Hacr
  @repeat_count : Int64
  @show_headers : Bool

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
    exit 1
  end

  def is_command?(string)
    /\A\w+\z/ =~ string
  end

  def handle_null_command(options)
    if options.size == 0 || !is_command?(options[0])
      Out.puts USAGE
      exit
    end
  end

  def handle_command(command)
    command_word = command[0].downcase
    return unless is_command?(command_word)
    case command_word
    when .starts_with?("help")
      Out.puts USAGE
    when .starts_with?("version")
      Out.puts VERSION
      exit
    when .starts_with?("list")
      Commands.do_list_command(@repeat_count, 3600, @show_headers, list_headers, column_widths)
    else
      Out.puts "unknown command #{command_word}"
    end
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
        Out.puts parser.to_s
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

Hacr.run(ARGV)
>>>>>>> fc253dd7486bfb9b76c4e7046982f74b5072756c
