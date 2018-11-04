require "./hue_resource"

class Light < HueResource

  def initialize(key, hashvalue, grouparray)
    super(key, hashvalue)
    @grouparray = grouparray
    @onstate = hashvalue.dig("state", "on")
    @brightstate = hashvalue.dig("state", "bri")
    @combinedsate = "#{@onstate} (#{@brightstate})"
    @number = key
    @group = Group.owning(key, grouparray)
    gen_reskey("l")
    build_name
    @state.merge! ({"on" => @combinedsate})
  end

  def build_name
    @state["detail"] += " in " + Group.owning(@number, @grouparray).first.name
  end
  
  def array(selectors)
    selectors.map { |key| @state[key] }
  end
end