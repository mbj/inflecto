module Inflector
  # A singleton instance of this class is yielded by Inflector.inflections, which can then be used to specify additional
  # inflection rules. Examples:
  #
  #   Inflector.inflections do |inflect|
  #     inflect.plural /^(ox)$/i, '\1\2en'
  #     inflect.singular /^(ox)en/i, '\1'
  #
  #     inflect.irregular 'octopus', 'octopi'
  #
  #     inflect.uncountable "equipment"
  #   end
  #
  # New rules are added at the top. So in the example above, the irregular rule for octopus will now be the first of the
  # pluralization and singularization rules that is runs. This guarantees that your rules run before any of the rules that may
  # already have been loaded.
  class Inflections
    def self.instance
      @__instance__ ||= new
    end

    attr_reader :plurals, :singulars, :uncountables, :humans

    def initialize
      @plurals, @singulars, @uncountables, @humans = [], [], [], []
    end

    # Specifies a new pluralization rule and its replacement. The rule can either be a string or a regular expression.
    # The replacement should always be a string that may include references to the matched data from the rule.
    def plural(rule, replacement)
      @uncountables.delete(rule) if rule.is_a?(String)
      @uncountables.delete(replacement)
      @plurals.insert(0, [rule, replacement])
    end

    # Specifies a new singularization rule and its replacement. The rule can either be a string or a regular expression.
    # The replacement should always be a string that may include references to the matched data from the rule.
    def singular(rule, replacement)
      @uncountables.delete(rule) if rule.is_a?(String)
      @uncountables.delete(replacement)
      @singulars.insert(0, [rule, replacement])
    end

    # Specifies a new irregular that applies to both pluralization and singularization at the same time. This can only be used
    # for strings, not regular expressions. You simply pass the irregular in singular and plural form.
    #
    # Examples:
    #   irregular 'octopus', 'octopi'
    #   irregular 'person', 'people'
    def irregular(singular, plural)
      @uncountables.delete(singular)
      @uncountables.delete(plural)
      if singular[0,1].upcase == plural[0,1].upcase
        plural(Regexp.new("(#{singular[0,1]})#{singular[1..-1]}$", "i"), '\1' + plural[1..-1])
        plural(Regexp.new("(#{plural[0,1]})#{plural[1..-1]}$", "i"), '\1' + plural[1..-1])
        singular(Regexp.new("(#{plural[0,1]})#{plural[1..-1]}$", "i"), '\1' + singular[1..-1])
      else
        plural(Regexp.new("#{singular[0,1].upcase}(?i)#{singular[1..-1]}$"), plural[0,1].upcase + plural[1..-1])
        plural(Regexp.new("#{singular[0,1].downcase}(?i)#{singular[1..-1]}$"), plural[0,1].downcase + plural[1..-1])
        plural(Regexp.new("#{plural[0,1].upcase}(?i)#{plural[1..-1]}$"), plural[0,1].upcase + plural[1..-1])
        plural(Regexp.new("#{plural[0,1].downcase}(?i)#{plural[1..-1]}$"), plural[0,1].downcase + plural[1..-1])
        singular(Regexp.new("#{plural[0,1].upcase}(?i)#{plural[1..-1]}$"), singular[0,1].upcase + singular[1..-1])
        singular(Regexp.new("#{plural[0,1].downcase}(?i)#{plural[1..-1]}$"), singular[0,1].downcase + singular[1..-1])
      end
    end

    # Add uncountable words that shouldn't be attempted inflected.
    #
    # Examples:
    #   uncountable "money"
    #   uncountable "money", "information"
    #   uncountable %w( money information rice )
    def uncountable(*words)
      (@uncountables << words).flatten!
    end

    # Specifies a humanized form of a string by a regular expression rule or by a string mapping.
    # When using a regular expression based replacement, the normal humanize formatting is called after the replacement.
    # When a string is used, the human form should be specified as desired (example: 'The name', not 'the_name')
    #
    # Examples:
    #   human /_cnt$/i, '\1_count'
    #   human "legacy_col_person_name", "Name"
    def human(rule, replacement)
      @humans.insert(0, [rule, replacement])
    end

    # Clears the loaded inflections within a given scope (default is <tt>:all</tt>).
    # Give the scope as a symbol of the inflection type, the options are: <tt>:plurals</tt>,
    # <tt>:singulars</tt>, <tt>:uncountables</tt>, <tt>:humans</tt>.
    #
    # Examples:
    #   clear :all
    #   clear :plurals
    def clear(scope = :all)
      case scope
        when :all
          @plurals, @singulars, @uncountables = [], [], []
        else
          instance_variable_set "@#{scope}", []
      end
    end
  end
end
