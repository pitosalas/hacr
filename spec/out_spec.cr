require "./spec_helper"

describe "Check basic functionality" do
  it "works in capture mode" do
    Out.set_capture
    Out.p("Hello World")
    Out.capture.should eq "Hello World"
  end
end
