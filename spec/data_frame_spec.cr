require "./spec_helper"

describe "Simplest case" do
  it "can store and lookup" do
    df1 = DataFrame.new(["x", "y"], [["1", "2"], ["3", "4"]])
    df1.get("y", 1).should eq "4"
    df1.validate
  end

  it "initializes via constructor" do
    df1 = DataFrame.new(["x", "y"], [["1", "2"], ["3", "4"]])
    df1.labeled_row(1).should eq [["x", "3"], ["y", "4"]]
  end
end
