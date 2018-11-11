class Test
  @repeat_count : Int16

  def initialize(@commands : Array(String))
    @repeat_count = 1
  end

  def self.run(param)
    new(param).run
  end

  def run
    puts @commands
  end
end

Test.run(ARGV)
