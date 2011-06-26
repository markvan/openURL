require './finder'

class Tally
  def initialize(db, collection)
    @finder=Finder.new(db, collection)
    self
  end

  def choose
    puts "- - - - - - - - - - - - - - - - -"
    puts "Ready yourself peep, to choose a tally..."
    puts "- - - - - - - - - - - - - - - - -"

    i = 1
    array = []
    @finder.specs.each { |name, value| puts i.to_s << '  ' << name ; array[i-1] = name ; i += 1 }

    puts " "
    print 'please choose from the above by number: '
    name = gets.chomp
    puts "you chose " << array[name.to_i - 1]
    puts "- - - - - - - - - - - - - - - - -"
    @operation =  array[name.to_i - 1]
  end

  def do_it
    @finder.tally(@operation)
  end
end



operation = 'books_with_title'

t = Tally.new('testdb', 'shorttestcollection')
t.choose


t.do_it
