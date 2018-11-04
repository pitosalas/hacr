require "./spec_helper"

describe "Test Rule class" do
  it "can return the name property" do
    key, value = hub_status("rules")
    rule = Rule.new(key, value)
    rule.name.should eq "RpsIphone"
  end

  it "can return the On property" do
    key, value = hub_status("rules")
    rule = Rule.new(key, value)
    rule.array(["on"])[0].should eq "enabled"
  end
end
