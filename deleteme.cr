class X
  @@st = ""

  def self.add(str)
    @@st += str
  end

  def self.get
    @@st
  end
end

X.add("foo")
puts X.get
