require 'mongo'
require 'yaml'
require './spec_parser'

class Finder
  attr_reader :specs

  def initialize(db,collection)
    database     = Mongo::Connection.new.db(db)
    @collection  = database[collection]
    @specs = SpecParser.new('_tallies.dsl').parse_specs
  end

  def plain_name(s)
    "r['#{s}'].to_s.chop"
  end

  def action_name(s)
    "r['#{s.gsub(/\..*$/,'')}'].to_s.chop.#{s.gsub(/^[a-z_]*\./,'')}"
  end

  def action_name?(s)
    s =~ /\./
  end

  def setup_if_not_empty(out)
    out == '' ? '' : " << \"\t\" << "
  end

  def build_grouping(values)
    out=''
    values.split.each  do |s|
      if action_name?(s)
        out << setup_if_not_empty(out) << action_name(s)
      else
        out << setup_if_not_empty(out) << plain_name(s)
      end
    end
    out
  end

  def tally(spec)
    books = Hash.new(0)
    query = @collection.find(@specs[spec][:match_on])
    query.each do |r|
      books[  eval( build_grouping( @specs[spec][:group_with] ) )   ]  += 1
    end
    books.each { |name, value| puts value.to_s << "\t" << name.to_s }
  end


end











