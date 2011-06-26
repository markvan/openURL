require './finder'

class Tally

  def initialize(db, collection)
    @finder=Finder.new(db, collection)
    @tally_names = []
    @finder.specs.each { |name, value| @tally_names << name  }
    self
  end


  def set_operation(i)
    i = i.to_i
    @operation =  @tally_names[i - 1]
  end

  def choose
    puts "- - - - - - - - - - - - - - - - -"
    puts "Ready yourself peep, to choose a tally..."
    puts "- - - - - - - - - - - - - - - - -"

    i = 1
    @tally_names.each { |name| puts i.to_s << '  ' << name  ; i += 1 }

    puts " "
    print 'Please choose from the above by number: '
    response = gets.chomp
    puts "- - - - - - - - - - - - - - - - -"
    puts "Peep, you chose " << @tally_names[response.to_i - 1]
    puts "- - - - - - - - - - - - - - - - -"
    set_operation(response.to_i)
  end

  def do_it
    @finder.tally(@operation)
  end
end


t = Tally.new('mydb', 'testcollection')

#t = Tally.new('testdb', 'shorttestcollection')
ARGV.length > 0 ? t.set_operation(ARGV[0].to_i) : t.choose


t.do_it
