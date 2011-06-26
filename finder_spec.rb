require './finder.rb'

describe Finder do
  it "parses string" do
    finder=Finder.new
    str = "sid"
    finder.plain_name(str).should == "r['sid'].to_s << \"\t\" << "
  end
end
