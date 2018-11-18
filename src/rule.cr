require "./hue_resource"

class  ConditionAction

  property conditions : Array(String)
  property actions : Array(String)

  def initialize
    conditions = [] of String
    actions = [] of String
  end

  def to_s
    "Im to s"
    end
end

class Rule  < HueResource
  property conditions_actions : Array(ConditionAction)

  def initialize(timestamp, key, hashvalue)
    super
    conditions_actions = [] of ConditionAction
    parse_conitions_actions(hashvalue)
    @state.merge! ({"on" => hashvalue["status"].to_s, "detail" => pp_rule(hashvalue)})
    gen_reskey("r")
  end

  def self.owning(number, grouparray)
    grouparray.select { |group| group.lights.include? number}
  end

  def name
    @state["name"]
  end

  def parse_conitions_actions(hashvalue)
  end


  # def pp_rule(hv : JSON::Any)
  #   res = "#{pp_conditions(hv["conditions"])}"
  #   res += "#{pp_action(hv["actions"])}"
  #   res
  # end

  # def pp_conditions(hv : JSON::Any)
  #   res = "conditions:  "
  #   res = hv.as_a.map { |cond| pp_cond(cond).to_s}
  #   res.join(" and ")
  # end

  # def pp_cond(hv : JSON::Any)
  #   res = "#{hv["address"]} is #{hv["operator"]}"
  #   res += " to #{hv["value"]?.to_s}"
  # end

  # def pp_action(hv : JSON::Any)
  #   "a: #{hv[0].to_s}"
  # end

end



# Desired Output
# 07:20:30    r2                RpsIphone      enabled
#    IF /sensors/2/state/lastupdated dx to  and 
#       /sensors/2/state/presence eq to false =>
#    THEN
#        SET /sensors/3/state body TO presrence = false
