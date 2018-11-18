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
  property command_words : Array(String)
  property command_options : Array(String)
  property word_count
  property options_count

  USAGE = <<-USAGE
  Usage: hacr [command]
  Command:
      list                    show all home automation devices
      help                    show this help
      version                 show version
      show                    show status of an individual device
  USAGE

  VERSION = "0.1"

  def initialize(@cli_words : Array(String))
    @repeat_count = 1
    @show_headers = true
    @command_words = [] of String
    @command_options = [] of String
    @word_count = 0
    @options_count = 0
  end

  private getter cli_words

  def self.run(args)
    new(args).run
  end

  def run
    top_level_command_parse
    handle_null_command
    handle_options
    handle_command
  end

  def is_command?(string)
    /\A\w+\z/ =~ string
  end

  def handle_null_command
    if @word_count == 0
      Out.p USAGE
    end
  end

  def top_level_command_parse
    @word_count = 0
    @options_count = 0
    cli_words.each do |w|
      if is_command?(w)
        command_words.push(w)
        @word_count +=1
      else
        command_options.push(w)
        @options_count += 1
      end
    end
  end

  # Commands are <word> or <word> <param>
  def handle_command
    command_words.map(&.downcase)
    case command_words[0]
    when .starts_with?("help")
      Out.p USAGE
    when .starts_with?("version")
      Out.p VERSION
    when .starts_with?("list")
      Commands.do_list_command(@repeat_count, 3600, @show_headers)
    when .starts_with?("show")
      if command_words.size != 2
        report_unknown_command
      else
        Commands.do_show(command_words[1], @repeat_count, 3600, @show_headers)
      end      
    else
      report_unknown_command
    end
  end

  def report_unknown_command
    Out.p "Unknown command \"#{@cli_words.join(" ")}\""
  end

  def handle_options
    OptionParser.parse(@command_options) do |parser|
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
end
