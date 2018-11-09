require "./spec_helper"
# require_relative 'test_helper'

# class HueTest < Minitest::Test

#   describe "able to get state of philips hue bridge" do
#     it "returns a valid hash" do
#       state_h = Hue.bridge_state
#       state_h.must_be_instance_of Hash
#     end

#     it "returns all devices in a single array" do
#       state_h = Hue.bridge_state
#       hue = Hue.new(::Context.new, state_h)
#       res = hue.all_a ["name", "detail", "on"]
#       res.length.must_be :>, 0
#     end
#   end
# end

describe "able to get state of philips hue bridge" do
  it "returns a valid hash" do
    bridge_state = JSON.parse(Hue.bridge_state)
    bridge_state.should be_a JSON::Any
  end
  
  it "returns all devices in a single array" do
    context = Context.new
    context.set_property("hue_state", Hue.bridge_state)
    state = context.get_property_as_json("hue_state")
    state = state["groups"]
    sensors = state.as_h.map { |k, v| Sensor.new(k, v)}
    sensors.should be_a Array(Sensor)
  end

  it "is able to get a specifc set of properties" do 
    context = Context.new
    context.set_property("hue_state", Hue.bridge_state)
    hue = Hue.new(context)
    res = hue.all_a ["name", "detail"]
    res.should be_a Array(Array(String))
  end
end
