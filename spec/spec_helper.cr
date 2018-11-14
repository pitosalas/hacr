require "spec"
require "JSON"
require "../src/rule.cr"
require "../src/hue.cr"
require "../src/context.cr"
require  "../src/group.cr"
require  "../src/light.cr"
require  "../src/sensor.cr"
require  "../src/out.cr"
require  "../src/cli_hacr.cr"


def hub_status_json_fixture : Hash(String, JSON::Any)
  JSON.parse(File.read("spec/fixtures/state3.json")).as_h
end

def hub_status(key)
  json_fixture = hub_status_json_fixture
  pair = json_fixture[key].as_h
  {pair.first_key, pair.first_value}
end


# json_fixture = hub_status_json_fixture
# pair = json_fixture["rules"].as_h
# rule = Rule.new(pair.first_key, pair.first_value)
# rule.array(["on"])[0].should eq "enabled"
