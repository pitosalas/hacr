require "./spec_helper"

describe "able to build a Rule" do
  it "returns all Rules in a single array" do
    bridge_state = Hue.bridge_state
    context = Context.new
    state = bridge_state["rules"]
    sensors_array = state.as_h.map { |k, v| Rule.new(k, v)}
    sensors_array.should be_a Array(Rule)
  end
end


# require "./spec_helper"

# describe "Test Rule class" do
#   it "can return the name property" do
#     key, value = hub_status("rules")
#     rule = Rule.new(key, value)
#     rule.name.should eq "RpsIphone"
#   end

#   it "can return the On property" do
#     key, value = hub_status("rules")
#     rule = Rule.new(key, value)
#     rule.array(["on"])[0].should eq "enabled"
#   end
# end
