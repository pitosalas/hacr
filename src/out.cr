class Out

  @@mode = :stdout
  @@capture = String.new

  def self.set_capture
    @@mode = :capture
    @@capture = ""
  end

  def self.puts(string)
    case @@mode
    when :stdout
      puts string
    when :capture
      @@capture += string
    end
  end

  def self.reset_mock
    @@capture = String.new
  end

  def self.capture
    @@capture
  end
end
