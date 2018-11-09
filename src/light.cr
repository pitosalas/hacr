require "./hue_resource"

class Light < HueResource
  @brightstate : String
  @onstate : String

  def initialize(key : String, hashvalue, grouparray)
    super(key, hashvalue)
    # @grouparray = grouparray
    @onstate = hashvalue["state"]["on"].to_s
    @brightstate = hashvalue["state"]["bri"].to_s
    @combinedsate = "#{@onstate} (#{@brightstate})"
    @number = key
    # @group = Group.owning(key, grouparray)
    gen_reskey("l")
    # build_name
    @state.merge! ({"on" => @combinedsate})
  end

  def build_name
    @state["detail"] += " in " + Group.owning(@number, @grouparray).first.name
  end
  
  def array(selectors)
    selectors.map { |key| @state[key] }
  end
end