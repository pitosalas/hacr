require "./spec_helper"

describe "Test Context class" do
  it "can create or open the database" do
    c = Context.new
    c.create_or_open
    c.get_property("hue_state").should be_a String
  end

  it "can update a value correctly" do
    c = Context.new
    c.create_or_open
    rand = Random.rand
    c.set_property("hue_state", %<{values: #{rand}}>)
    c.get_property("hue_state").should eq %<{values: #{rand}}>
  end
end
