module Inflecto
  # A singleton instance of this class is yielded by Inflecto.inflections, which can then be used to specify additional
  # inflection rules. Examples:
  #
  #   Inflecto.inflections do |inflect|
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
  #
  class Inflections

    # Return instance
    #
    # @return [Inflections]
    #
    # @api private
    #
    def self.instance
      @__instance__ ||= new
    end

    # Return plurals
    #
    # @return [Array]
    #
    # @api private
    #
    attr_reader :plurals

    # Return singulars
    #
    # @return [Array]
    #
    # @api private
    #
    attr_reader :singulars

    # Return uncountables
    #
    # @return [Array]
    #
    # @api private
    #
    attr_reader :uncountables

    # Return humans
    #
    # @return [Array]
    #
    # @api private
    #
    #
    attr_reader :humans

    # Initialize object
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize
      @plurals      = RulesCollection.new
      @singulars    = RulesCollection.new
      @humans       = RulesCollection.new
      @uncountables = []
    end

    # Add a new plural role
    #
    # Specifies a new pluralization rule and its replacement. The rule can either be a string or a regular expression.
    # The replacement should always be a string that may include references to the matched data from the rule.
    #
    # @param [String, Regexp] rule
    # @param [String, Regexp] replacement
    #
    # @return [self]
    #
    # @api private
    #
    def plural(rule, replacement)
      rule(rule, replacement, @plurals)
      self
    end

    # Add a new singular rule
    #
    # Specifies a new singularization rule and its replacement. The rule can either be a string or a regular expression.
    # The replacement should always be a string that may include references to the matched data from the rule.
    #
    # @param [String, Regexp] rule
    # @param [String, Regexp] replacement
    #
    # @return [self]
    #
    # @api private
    #
    def singular(rule, replacement)
      rule(rule, replacement, @singulars)
      self
    end

    # Add a new irregular pluralization
    #
    # Specifies a new irregular that applies to both pluralization and singularization at the same time. This can only be used
    # for strings, not regular expressions. You simply pass the irregular in singular and plural form.
    #
    # @example
    #
    #   Inflecto.irregular('octopus', 'octopi')
    #   Inflecto.irregular('person', 'people')
    #
    # @param [String] singular
    # @param [String] plural
    #
    # @return [self]
    #
    # @api private
    #
    def irregular(singular, plural)
      @uncountables.delete(singular)
      @uncountables.delete(plural)
      add_irregular(singular, plural, @plurals)
      add_irregular(plural, singular, @singulars)
      self
    end

    # Add uncountable words
    #
    # Uncountable will not be inflected
    #
    # @example
    #
    #   Inflecto.uncountable "money"
    #   Inflecto.uncountable "money", "information"
    #   Inflecto.uncountable %w( money information rice )
    #
    # @param [Enumerable<String>] words
    #
    # @return [self]
    #
    # @api private
    #
    def uncountable(*words)
      @uncountables.concat(words.flatten)
      self
    end

    # Add humanize rule
    #
    # Specifies a humanized form of a string by a regular expression rule or by a string mapping.
    # When using a regular expression based replacement, the normal humanize formatting is called after the replacement.
    # When a string is used, the human form should be specified as desired (example: 'The name', not 'the_name')
    #
    # @example
    #   Inflecto.human(/_cnt$/i, '\1_count')
    #   Inflecto.human("legacy_col_person_name", "Name")
    #
    # @param [String, Regexp] rule
    # @param [String, Regexp] replacement
    #
    # @api private
    #
    # @return [self]
    #
    def human(rule, replacement)
      @humans.insert(0, [rule, replacement])
      self
    end

    # Clear all inflection rules
    #
    # @example
    #
    #   Inflecto.clear
    #
    # @return [self]
    #
    # @api private
    #
    def clear
      initialize
      self
    end

    private

    # Add irregular inflection
    #
    # @param [String] rule
    # @param [String] replacement
    #
    # @return [undefined]
    #
    # @api private
    #
    def add_irregular(rule, replacement, target)
      head, *tail = rule.chars.to_a
      rule(/(#{head})#{tail.join}\z/i, '\1' + replacement[1..-1], target)
    end

    # Add a new rule
    #
    # @param [String, Regexp] rule
    # @param [String, Regexp] replacement
    # @param [Array] target
    #
    # @return [undefined]
    #
    # @api private
    #
    def rule(rule, replacement, target)
      @uncountables.delete(rule)
      @uncountables.delete(replacement)
      target.insert(0, [rule, replacement])
    end

  end
end
