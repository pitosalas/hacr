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
    puts "listing"
  end

end

Hacr.run(ARGV)
