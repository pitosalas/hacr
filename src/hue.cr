
require "json"
require "crest"

BRIDGE_IP = "10.0.0.89"
USERNAME = "78UEGUotX3otmWxbhiucELCLiiKmaD9E2O5YW-d1"

class Hue
  @timestamp : String
  @groups : Array(Group)
  @lights : Array(Light)
  @sensors : Array(Sensor)
  @rules : Array(Rule)
  @resources : Array(HueResource)
  @hue_state : JSON::Any
  
  def initialize(context : Context)
    @context = context
    @hue_state = JSON.parse(context.get_property("hue_state"))
    @timestamp = @hue_state["config"]["UTC"].to_s
    @groups = groups
    @sensors =  sensors
    @lights = lights
    @rules = rules
    @resources = @groups + @sensors + @lights + @rules
  end

  def self.bridge_state
    response = Crest.get("http://#{BRIDGE_IP}/api/#{USERNAME}/").body
  end

  def pair
    @context[:useraccount] = "12345"
    @context.save
  end

  def find(find_what)
    @resources.select { |r| r.id == find_what }
  end

  def sensors
    state = @hue_state["sensors"]
    state.as_h.map { |k, v| Sensor.new(@timestamp, k, v)}
  end

  def lights
    state = @hue_state["lights"]
    state.as_h.map { |k, v| Light.new(@timestamp, k, v, @groups)}
  end

  def groups
    state = @hue_state["groups"]
    state.as_h.map { |k, v| Group.new(@timestamp, k, v)}
  end

  def rules
    state = @hue_state["rules"]
    state.as_h.map { |k, v| Rule.new(@timestamp, k, v)}
  end

  def all_a  (selector)
    items =  sensors_a selector
    items +=  lights_a selector
    items +=  groups_a selector
    items += rules_a selector
  end

  def sensors_a (selector)
    sensors.map { |sensor| sensor.array(selector)}
  end

  def lights_a (selector)
    lights.map { |light| light.array(selector)}
  end

  def groups_a (selector)
    groups.map { |group| group.array(selector)}
  end

  def rules_a (selector)
    rules.map { |rule| rule.array(selector)}
  end

end
