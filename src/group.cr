require "./hue_resource"

class Group  < HueResource
  getter :detail, :on, :name, :lights
  def initialize(key, hashvalue)
    super
    @lights = hashvalue["lights"]
    @lights_s = hashvalue["lights"].join(",")
    gen_reskey("g")
    @state.merge! ({"on" =>@lights_s, "name" => @name, "detail" => @detail})
  end

  def array(selectors)
    selectors.map { |key| @state[key] }
  end

  def self.owning(number, grouparray)
    grouparray.select { |group| group.lights.include? number}
  end
end