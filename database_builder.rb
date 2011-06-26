require 'mongo'
require 'csv'


class DatabaseBuilder
  attr_reader :db, :collection

  def initialize(test_db, test_collection)
    @db = Mongo::Connection.new.db(test_db)
    @collection=db[test_collection]
  end

  def make_doc(names, values)
    doc = {}
    (0...names.length).each { |i| doc[names[i]] = values[i] }
    doc
  end

  def populate(csv_file)
    records = CSV.read(csv_file, {:col_sep=>"\t"})
    first = true
    fields = []
    records.each do |rec|
      if first
        fields = rec
        first = false
      else
        d = make_doc(fields, rec)
        @collection.insert d
      end
    end
  end
end
