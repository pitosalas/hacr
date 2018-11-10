require "./spec_helper"

describe "able to build a sensor" do
  it "returns all sensors in a single array" do
    bridge_state = hub_status_json_fixture # Hue.bridge_state
    context = Context.new
    state = bridge_state["sensors"]
    sensors_array = state.as_h.map { |k, v| Sensor.new(k, v)}
    sensors_array.should be_a Array(Sensor)
  end
end

it "returns all Sensors in a single array" do
  context = Context.new
  context.set_property("hue_state", Hue.bridge_state)
  state = context.get_property_as_json("hue_state")
  state = state["sensors"]
  sensors = state.as_h.map { |k, v| Sensor.new(k, v)}
  sensors.should be_a Array(Sensor)
end

