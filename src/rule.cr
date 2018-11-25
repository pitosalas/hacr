require "./hue_resource"



# Handling of Rules
# Convert the rule json into two propertores, conditons: and actions: 
# Pretty printed as follows:
#
#      conditions: sensors(3).presence  true and
#                  sensors(3).lastupdated changed  and
#                  sensors(1).daylight  false
#         actions: groups(1). PUT {"scene" => "GX9QiSrGsRJMM92"}
#
# An alternative even briefer format might be: if s3.pres & s3.delta & s1.daylight THEN g1.scene = s5
# 
class Rule < HueResource
  def initialize(timestamp, key, hashvalue)
    super
    @state.merge! ({"on"         => hashvalue["status"].to_s,
                    "conditions" => pp_conditions(hashvalue["conditions"]),
                    "actions"    => pp_actions(hashvalue["actions"])})
    gen_reskey("rule")
  end

  def self.owning(number, grouparray)
    grouparray.select { |group| group.lights.include? number }
  end

  def name
    @state["name"]
  end

  def pp_conditions(hv : JSON::Any)
    res = hv.as_a.map { |cond| pp_cond(cond).to_s }
    res.join(" and\n                 ")
  end

  def pp_cond(hv : JSON::Any)
    res = [pp_address(hv["address"].to_s),
           pp_operator(hv["operator"]),
           pp_value(hv["value"]?)]
    res.join(" ")
  end

  def pp_address(address : String)
    dev = num = prop = ""
    reg = /\/([a-z]+)\/(\d+)\/(?>state|action|presence)(?>\/([a-z]+))*/
    if md = reg.match(address)
      dev = md[1]
      num = md[2]
      prop = md[3] unless md[3]?.nil?
    end
    dev + "(" + num + ")." + prop
  end

  def pp_operator(operator)
    operator = "changed" if operator == "dx"
  end

  def pp_value(value)
    value
  end

  def pp_actions(hv : JSON::Any)
    res = hv.as_a.map { |action| pp_action(action)}
    res.join(" and\n                 ")
  end

  def pp_action(hv : JSON::Any)
    res = [pp_address(hv["address"].to_s),
          pp_value(hv["method"].to_s),
          pp_value(hv["body"]?).to_s]
    res.join(" ")
  end
end
