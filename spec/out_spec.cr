require "./spec_helper"

describe "Check basic functionalioty" do
  it "works in capture mode" do
    Out.set_capture
    Out.puts("Hello World")
    Out.capture.should eq "Hello World"
  end
end
