require "./spec_helper"

describe "able to build a Rule" do
  it "returns all Rules in a single array" do
    context = Context.new
    context.set_property("hue_state", Hue.bridge_state)
    state = context.get_property_as_json("hue_state")
    state = state["rules"]
    rules = state.as_h.map { |k, v| Rule.new("2018-10-22T22:38:26", k, v) }
    rules.should be_a Array(Rule)
  end

  it "can return the name property" do
    key, value = hub_status("rules")
    rule = Rule.new("2018-10-22T22:38:26", key, value)
    rule.name.should eq "RpsIphone"
  end

  it "can return the On property" do
    key, value = hub_status("rules")
    rule = Rule.new("2018-10-22T22:38:26", key, value)
    rule.array(["on"])[0].should eq "enabled"
  end
end
