require "./spec_helper"

describe "simple table cases" do
  it "can handle a emoty table" do
    table = CliTable.new(false) 
    table.row_headers = [] of String
    table.rows = [] of Array(String)
    table.column_widths = [] of Int32
    Out.set_capture
    Out.p table.render
    Out.capture.should eq ""
  end

  it "can handle a simple table" do
    table = CliTable.new(true) 
    table.row_headers = ["A", "B"]
    table.rows = [["1", "2"]]
    table.column_widths = [10, 20]
    Out.set_capture
    Out.p table.render
    Out.capture.should eq "          A                    B\n          1                    2\n"
  end

  it "can handle a table with a detail row" do
    table = CliTable.new(true) 
    table.row_headers = ["A", "B"]
    table.rows = [["1", "2"], ["3", "4"]]
    table.column_widths = [2,2]
    table.detail_labels = ["age", "loc"]
    table.detail_data = [["12", "boston"], ["13", "cambridge"]]
    Out.set_capture
    Out.p table.render
    Out.capture.should eq "  A  B\n  1  2\n    age: 12\n    loc: boston\n  3  4\n    age: 13\n    loc: cambridge\n"
  end

  it "can handle the new "

end
