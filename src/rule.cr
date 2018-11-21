require "./hue_resource"

class Rule  < HueResource

  def initialize(timestamp, key, hashvalue)
    super
    @state.merge! ({"on" => hashvalue["status"].to_s, 
                                "conditions" => pp_conditions(hashvalue["conditions"]),
                                "actions" => pp_action(hashvalue["actions"])})
    gen_reskey("r")
  end

  def self.owning(number, grouparray)
    grouparray.select { |group| group.lights.include? number}
  end

  def name
    @state["name"]
  end

  def pp_rule(hv : JSON::Any)
    res = "IF "
    res += "#{pp_conditions(hv["conditions"])}"
    res += "#{pp_action(hv["actions"])}"
    res
  end

  def pp_conditions(hv : JSON::Any)
    res = "conditions:  "
    res = hv.as_a.map { |cond| pp_cond(cond).to_s}
    res.join(" and ")
  end

  def pp_cond(hv : JSON::Any)
    res = [pp_address(hv["address"].to_s), 
              pp_operator(hv["operator"]), 
              pp_value(hv["value"]?)]
    res.join(" ")
  end

  def pp_address(address : String)
    dev = num = prop = ""
    reg =  /\/([a-z]+)\/(\d+)\/state\/([a-z]+)/
    if md = reg.match(address)
      dev = md[1]
      num =  md[2]
      prop =  md[3]
    end 
    dev + "(" + num  + ")." + prop
  end

  def pp_operator(operator)
    operator = "changed" if operator == "dx"
  end

  def pp_value(value)
    value
  end

  def pp_action(hv : JSON::Any)
    "#{hv[0].to_s}"
  end
end
