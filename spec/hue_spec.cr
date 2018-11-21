require "./spec_helper"

describe "able to get state of philips hue bridge" do
  it "returns a valid hash" do
    bridge_state = JSON.parse(Hue.bridge_state)
    bridge_state.should be_a JSON::Any
  end

  it "is able to get a specifc set of properties" do
    context = Context.new
    context.set_property("hue_state", Hue.bridge_state)
    hue = Hue.new(context)
    res = hue.all_a ["name", "id"]
    res.should be_a Array(Array(String))
    puts res
  end
end
