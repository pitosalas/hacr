require "./hue_resource"
class Rule  < HueResource

  def initialize(timestamp, key, hashvalue)
    super
    detail = "#{hashvalue["conditions"].size} conds => #{hashvalue["actions"].size} acts"
    @state.merge! ({"on" => hashvalue["status"].to_s, "detail" => detail})
    gen_reskey("r")
  end

  def array(selectors)
    selectors.map { |key| @state[key] }
  end

  def self.owning(number, grouparray)
    grouparray.select { |group| group.lights.include? number}
  end

  def name
    @state["name"]
  end
end
