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
    hue = Hue.new(context, Hue.bridge_state)
    table = CliTable.new
    table.headers = list_headers
    table.rows =  hue.all_a list_headers
    table.column_widths = column_widths
    puts table.render
  end

end

Hacr.run(ARGV)
