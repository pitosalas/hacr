require "./spec_helper"

def f1
  f1 = DataFrame.new(["x", "y"], [["x1", "y1"],
                                  ["x2", "y2"],
                                  ["x3", "y3"]])
  f1.validate
  f1
end

describe "simple report case" do
  it "columns and no detail" do
    report = Report.new(f1)
    report.column_widths = [10, 10]
    report.detail_labels = [] of String
    report.column_headers = ["x", "y"]
    Out.set_capture
    Out.p report.render
    Out.capture.should eq "          x          y\n         x1         y1\n         x2         y2\n         x3         y3\n"
  end

  it "can handle a simple report" do
    report = Report.new(DataFrame.new(field_names: ["A", "B"], row_data: [["1", "2"], ["3", "4"]]))
    report.show_headers = true
    report.column_widths = [10, 20]
    report.column_headers = ["A", "B"]
    report.detail_labels = [] of String
    Out.set_capture
    Out.p report.render
    Out.capture.should eq "          A                    B\n          1                    2\n          3                    4\n"
  end

  it "can handle a report with a detail row" do
    report = Report.new(DataFrame.new(["A", "B"], [["1", "2"], ["3", "4"]]))
    report.column_widths = [2, 2]
    report.column_headers = ["A"]
    report.detail_labels = ["B"]
    Out.set_capture
    Out.p report.render
    Out.capture.should eq "  A\n" + "  1\n" + "    B: 2\n" + "  3\n" + "    B: 4\n"
  end
end
