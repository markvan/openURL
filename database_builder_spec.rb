require './database_builder.rb'

describe DatabaseBuilder do

  it "should make a document for the database" do
    collection = DatabaseBuilder.new 'testdb', 'newtestcollection'
    collection.make_doc(['a', 'b', 'c'], ['aa', 'bb', 'cc']).should == { 'a' => 'aa', 'b' => 'bb', 'c' => 'cc'}
    collection.collection.drop
  end

  it "should create an empty database" do
    collection = DatabaseBuilder.new 'testdb', 'newtestcollection'
    collection.db.class.should == Mongo::DB
    collection.collection.class.should == Mongo::Collection
    collection.collection.size.should == 0
    collection.collection.drop
  end

  it "should load the database with correct number of items" do
    collection = DatabaseBuilder.new 'testdb', 'newtestcollection'
    collection.populate('csv tiny.csv')
    collection.collection.size.should == 4
    collection.collection.drop
  end

  it "should load the database with the correct content" do
    collection = DatabaseBuilder.new 'testdb', 'newtestcollection'
    collection.populate('csv tiny.csv')

    doc = collection.collection.find_one
    doc.delete("_id")
    doc.should ==  {"logDate"=>"2011-04-01", "logTime"=>"00:00:02", "encryptedUserIP"=>"wjaDM21mMRpDAJn+OR1EPH0Oric", "institutionResolverID"=>"290257", "routerRedirectIdentifier"=>"ukfed", "aulast"=>nil, "aufirst"=>nil, "auinit"=>nil, "auinit1"=>nil, "auinitm"=>nil, "au"=>nil, "aucorp"=>nil, "atitle"=>"Classification for effective rehabilitation: rediscovering psychology.", "title"=>"Criminal Justice & Behavior", "jtitle"=>nil, "stitle"=>nil, "date"=>"19900101", "ssn"=>nil, "quarter"=>nil, "volume"=>"17", "part"=>nil, "issue"=>"1", "spage"=>"19", "epage"=>nil, "pages"=>nil, "artnum"=>nil, "issn"=>"0093-8548", "eissn"=>nil, "isbn"=>nil, "coden"=>nil, "sici"=>nil, "genre"=>"article", "btitle"=>nil, "place"=>nil, "pub"=>nil, "edition"=>nil, "tpages"=>nil, "series"=>nil, "doi"=>nil, "sid"=>nil}

    #todo refactor
    rec = 0
    i = 0
    collection.collection.find({'logDate' => '2011-04-04'}).each {|v| rec = v; i += 1}
    rec.delete("_id")
    rec.should ==  {"logDate"=>"2011-04-04", "logTime"=>"00:00:13", "encryptedUserIP"=>"NZgv4zdS1OyCzRbBxwlOU2H4U2A", "institutionResolverID"=>"305037", "routerRedirectIdentifier"=>"athens", "aulast"=>"BUTEAU", "aufirst"=>nil, "auinit"=>"C", "auinit1"=>nil, "auinitm"=>nil, "au"=>"DUITSCHAEVER, C\u0000ASHTON, G", "aucorp"=>nil, "atitle"=>"VINIFICATION OF 3 WHITE GRAPE VARIETIES BY 3 DIFFERENT METHODS .1. FERMENTATION PROCESS AND WINE COMPOSITION", "title"=>"AMERICAN JOURNAL OF ENOLOGY AND VITICULTURE", "jtitle"=>nil, "stitle"=>"AM J ENOL VITICULT", "date"=>"1979", "ssn"=>nil, "quarter"=>nil, "volume"=>"30", "part"=>nil, "issue"=>"2", "spage"=>"139", "epage"=>"145", "pages"=>nil, "artnum"=>nil, "issn"=>"0002-9254", "eissn"=>nil, "isbn"=>nil, "coden"=>nil, "sici"=>nil, "genre"=>"article", "btitle"=>nil, "place"=>"DAVIS", "pub"=>"AMER SOC ENOLOGY VITICULTURE", "edition"=>nil, "tpages"=>nil, "series"=>nil, "doi"=>nil, "sid"=>"www.isinet.com:WoK:WOS"}
    i.should == 1

    collection.collection.drop
  end


end