class SpecParser
  def initialize(file)
    @hash = {}
    @f = File.new(file)
    self
  end

  def get_line
    @f.readline.chomp!
  end

  def add_single_match_spec_to(matches)
    field = get_line.gsub(/^ +field = /, "").gsub(/\n/, "")
    str_pattern = get_line.gsub(/^ +pattern = /, "").gsub(/\n/, "")
    pattern = Regexp.new(str_pattern.gsub!(/\//,"") )
    matches[field] = pattern
  end

  def parse_grouping(line)
    line.gsub(/^group = /, "").gsub(/\n/, "")
  end

  def parse_spec()
    line = get_line

    #parse one or more matches
    matches = {}
    begin
      add_single_match_spec_to (matches)
      line = get_line
    end until line =~ /group/

    #parse one or more grouping specifers
    grouping =  parse_grouping(line)
    #return the newly parsed spec

    { match_on: matches ||= :none, group_with: grouping ||= :none }
  end

  def parse_specs
    specs = {}
    begin
      while (spec_name = get_line)
        specs[spec_name] = parse_spec() unless spec_name.empty?
      end
    rescue # deals with eof
    end
    specs
  end
end

