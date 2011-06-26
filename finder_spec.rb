require './finder.rb'

describe Finder do
  it "should change a plain name to a field lookup" do
    finder=Finder.new('testdb', 'shorttestcollection')
    finder.plain_name("sid").should == "r['sid'].to_s.chop"
  end

  it "should change an action name to a field lookup and message send" do
    finder=Finder.new('testdb', 'shorttestcollection')
    finder.action_name( "sid.barret"                 ).should == "r['sid'].to_s.chop.barret"
    finder.action_name( "sid.barret()"               ).should == "r['sid'].to_s.chop.barret()"
    finder.action_name( "sid.gsub(/(:|\/).*$/,\"\")" ).should == "r['sid'].to_s.chop.gsub(/(:|/).*$/,\"\")"

  end
end

#todo retrofit  tests (= bad) lots more tests for other Finder#methods