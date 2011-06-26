require './database_builder'


class Builder
  def initialize(db, collection, csv)
    collection = DatabaseBuilder.new(db, collection)
    collection.populate(csv)
    puts collection.collection.size.to_s << "records in database"
  end
end

puts "working..."
collect = Builder.new('testdb', 'shorttestcollection', 'csv tiny.csv')
puts