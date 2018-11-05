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
    state_h = Hue.bridge_state
    state_h.should be_a String
  end
  
  it "returns all devices in a single array" do
    state_h = Hue.bridge_state
    context = Context.new
    context.set_property("hue_state", state_h)
    # hue = Hue.new(context, state_h)
    # res = hue.all_a ["name", "detail", "on"]
    # res.length.must_be :>, 0
  end

end
