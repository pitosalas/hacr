require "./spec_helper"

describe "Test Context class" do
  it "can create or open the database" do
    c = Context.new
    c.create_or_open
  end
end
