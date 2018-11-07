
require "json"
require "crest"
require "./hue_resource"

# require "./sensor"
# require "./light"
# require "./group"
require "./rule"

BRIDGE_IP = "10.0.0.89"
USERNAME = "78UEGUotX3otmWxbhiucELCLiiKmaD9E2O5YW-d1"

class Hue
  def initialize(context : Context)
    @context = context
    hue_state = JSON.parse(context.get_property("hue_state"))
    @groups =  groups(hue_state)
    @sensors =  sensors(hue_state)
    @lights =  lights(hue_state)
  end

  def self.bridge_state
    response = Crest.get("http://#{BRIDGE_IP}/api/#{USERNAME}/")
    JSON.parse(response.body)
  end

  def pair
    @context[:useraccount] = "12345"
    @context.save
  end

  def sensors
    parsed = @bridge_state["sensors"]
    parsed.to_a.map { |sensor_pair| Sensor.new(*sensor_pair)}
  end

  def lights(hue_state)
    parsed = hue_state["lights"]
    parsed.to_a.map { |light_pair| Light.new(*light_pair, @groups)}
  end

  def groups(hue_state)
    state = hue_state["groups"]
    state.as_h.each { |k, v| puts "********", k, v }
    state.as_h.eac { |group_pair| Group.new(*group_pair)}
  end

  def rules(hue_state)
    parsed = hue_state["rules"]
    parsed.to_a.map { |rule_pair| Rule.new(*rule_pair)}
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
