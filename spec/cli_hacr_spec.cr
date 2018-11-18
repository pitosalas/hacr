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
    h = CliHacr.new(%w(list -c0))
    Out.set_capture
    h.run
    h.repeat_count.should eq 0
  end

  it "is able to see multi word commands" do
    h = CliHacr.new(%w(a b c d))
    h.top_level_command_parse
    h.word_count.should eq 4
    h.options_count.should eq 0
  end

  it "is able to see multiple options" do
    h = CliHacr.new(%w(-w -2 -4004))
    h.top_level_command_parse
    h.word_count.should eq 0
    h.options_count.should eq 3
  end
end
