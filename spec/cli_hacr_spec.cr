require "./spec_helper"

describe "able to process commands" do
  # it "returns a valid hash" do
  #   bridge_state = JSON.parse(Hue.bridge_state)
  #   bridge_state.should be_a JSON::Any
  # end

  # it "is able to get a specifc set of properties" do
  #   context = Context.new
  #   context.set_property("hue_state", Hue.bridge_state)
  #   hue = Hue.new(context)
  #   res = hue.all_a ["name", "detail"]
  #   res.should be_a Array(Array(String))
  # end

  it "is able to process HELP command" do
    h = CliHacr.new(["help"])
    Out.set_capture
    h.run
    Out.capture.should be_a(String)
  end

  it "is able to parse switches" do
    h = CliHacr.new(%w(list -c 0))
    Out.set_capture
    h.run
    h.repeat_count.should eq 0
  end
end
