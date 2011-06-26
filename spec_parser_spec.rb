require './spec_parser.rb'

describe Finder do
  it "should parse simple groupings" do
    finder=Finder.new
    str = "sid"
    finder.plain_name(str).should == "r['sid'].to_s"
  end

  it "should parse groupins with actions" do
    finder=Finder.new
    str = "sid.sub"
    finder.action_name(str).should == "r['sid'].to_s.sub"
    str = "sid.sub()"
    finder.action_name(str).should == "r['sid'].to_s.sub()"
    str = "sid.gsub(/abc/,'')"
    finder.action_name(str).should == "r['sid'].to_s.gsub(/abc/,'')"
    str = "sid.gsub(/(:|\/)\.*/,\"\")"
    finder.action_name(str).should == "r['sid'].to_s.gsub(/(:|\/).*/,\"\")"
  end


  it "should build an aggregation token" do
    finder=Finder.new
    str = "sid barret"
    finder.build_grouping(str).should == "r['sid'].to_s << \"\t\" << r['barret'].to_s"
  end



end