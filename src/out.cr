class Out
  @@mode = :stdout
  @@capture = ""

  def self.set_capture
    @@mode = :capture
    reset_capture
    log("setcapture")
  end

  def self.p(string : String)
    case @@mode
    when :stdout
      puts string
    when :capture
      @@capture += string
    end
    log("p")
  end

  def self.capture
    log("capture")
    @@capture
  end

  def self.reset_capture
    @@capture = ""
    log("reset_capture")
  end

  def self.log(w)
    # puts "log: Capture #{w} = #{@@capture}"
  end
end
