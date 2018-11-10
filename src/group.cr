require "./hue_resource"

class Group  < HueResource
  getter :detail, :on, :name
  def initialize(key, hashvalue)
    super
    lights = hashvalue["lights"].as_a
    light_list_string = lights.map { |l| l.to_s }.join(", ")
    gen_reskey("g")
    @state.merge! ({"on" =>light_list_string})
  end

  def array(selectors)
    selectors.map { |key| @state[key] }
  end

  def self.owning(number, grouparray)
    grouparray.select { |group| group.lights.include? number}
  end
end