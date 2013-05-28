# The Inflecto transforms words from singular to plural, class names to table names, modularized class names to ones without,
# and class names to foreign keys. The default inflections for pluralization, singularization, and uncountable words are kept
# in inflections.rb.
#
# The Rails core team has stated patches for the inflections library will not be accepted
# in order to avoid breaking legacy applications which may be relying on errant inflections.
# If you discover an incorrect inflection and require it for your application, you'll need
# to correct it yourself (explained below).
module Inflecto

  # Convert input to UpperCamelCase
  #
  # Will also convert '/' to '::' which is useful for converting paths to namespaces.
  #
  # @param [String] input
  #
  # @example
  #   Inflecto.camelize("data_mapper")        # => "DataMapper"
  #   Inflecto.camelize("data_mapper/errors") # => "DataMApper::Errors"
  #
  # @return [String]
  #
  # @api public
  #
  def self.camelize(input)
    input.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:\A|_)(.)/) { $1.upcase }
  end

  # Convert input to underscored, lowercase string
  #
  # Changes '::' to '/' to convert namespaces to paths.
  #
  # @param [String] input
  #
  # @example
  #   Inflecto.underscore("DataMapper")         # => "data_mapper"
  #   Inflecto.underscore("DataMapper::Errors") # => "data_mapper/errors"
  #
  # @return [String]
  #
  # @api public
  #
  def self.underscore(input)
    word = input.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!('-', '_')
    word.downcase!
    word
  end

  # Convert input underscores to dashes
  #
  # @param [String] input
  #
  # @example
  #   Inflecto.dasherize("foo_bar") # => "foo-bar"
  #
  # @return [String]
  #
  # @api public
  #
  def self.dasherize(input)
    input.gsub(/_/, '-')
  end

  # Return unscoped constant name
  #
  # @param [String] input
  #
  # @example
  #
  #   Inflecto.demodulize("DataMapper::Error") # => "Error"
  #   Inflecto.demodulize("DataMapper")        # => "DataMapper"
  #
  # @return [String]
  #
  # @api public
  #
  def self.demodulize(input)
    input.gsub(/\A.*::/, '')
  end

  # Creates a foreign key name
  #
  # @param [String] input
  #
  # @example
  #
  #   Inflecto.foreign_key("Message) => "message_id"
  #
  # @return [String]
  #
  # @api private
  #
  def self.foreign_key(input)
    "#{underscore(demodulize(input))}_id"
  end

  EXTRA_CONST_ARGS = (RUBY_VERSION < '1.9' ? [] : [ false ]).freeze

  # Find a constant with the name specified in the argument string
  #
  # The name is assumed to be the one of a top-level constant, constant scope of caller is igored
  #
  # @param [String] input
  #
  # @example
  #
  #   Inflecto.constantize("Module")            # => Module
  #   Inflecto.constantize("DataMapper::Error") # => Test::Unit
  #
  # @return [Class, Module]
  #
  # @api private
  #
  def self.constantize(input)
    names = input.split('::')
    names.shift if names.any? and names.first.empty?

    names.inject(Object) do |constant, name|
      if constant.const_defined?(name, *EXTRA_CONST_ARGS)
        constant.const_get(name)
      else
        constant.const_missing(name)
      end
    end
  end

  # Convert a number into an ordinal string
  #
  # @param [Fixnum] number
  #
  # @example
  #
  #   ordinalize(1)     # => "1st"
  #   ordinalize(2)     # => "2nd"
  #   ordinalize(1002)  # => "1002nd"
  #   ordinalize(1003)  # => "1003rd"
  #
  # @return [String]
  #
  # @api private
  #
  def self.ordinalize(number)
    abs_value = number.abs

    if (11..13).include?(abs_value % 100)
      "#{number}th"
    else
      case abs_value % 10
        when 1; "#{number}st"
        when 2; "#{number}nd"
        when 3; "#{number}rd"
        else    "#{number}th"
      end
    end
  end

  # Yields a singleton instance of Inflecto::Inflections
  #
  # @example
  #
  #   Inflecto.inflections do |inflect|
  #     inflect.uncountable "rails"
  #   end
  #
  # @return [Inflecto::Inflections]
  #
  # @api public
  #
  def self.inflections
    instance = Inflections.instance
    block_given? ? yield(instance) : instance
  end

  # Convert input word string to plural
  #
  # @param [String] word
  #
  # @example
  #
  #   Inflecto.pluralize("post")         # => "posts"
  #   Inflecto.pluralize("octopus")      # => "octopi"
  #   Inflecto.pluralize("sheep")        # => "sheep"
  #   Inflecto.pluralize("words")        # => "words"
  #   Inflecto.pluralize("CamelOctopus") # => "CamelOctopi"
  #
  # @return [String]
  #
  # @api public
  #
  def self.pluralize(word)
    return word if uncountable?(word)
    inflections.plurals.apply_to(word)
  end

  # Convert word to singular
  #
  # @param [String] word
  #
  # @example
  #
  #   Inflecto.singularize("posts") # => "post"
  #   Inflecto.singularize("octopi") # => "octopus"
  #   Inflecto.singularize("sheep") # => "sheep"
  #   Inflecto.singularize("word") # => "word"
  #   Inflecto.singularize("CamelOctopi") # => "CamelOctopus"
  #
  # @return [String]
  #
  # @api public
  #
  def self.singularize(word)
    return word if uncountable?(word)
    inflections.singulars.apply_to(word)
  end

  # Humanize string
  #
  # @param [String] input
  #
  # capitalizes the first word and turns underscores into spaces and strips a # trailing "_id", if any.
  # Like +titleize+, this is meant for creating pretty output.
  #
  # @example
  #
  #   Inflecto.humanize("employee_salary") # => "Employee salary"
  #   Inflecto.humanize("author_id")       # => "Author"
  #
  # @return [String]
  #
  # @api private
  #
  def self.humanize(input)
    result = inflections.humans.apply_to(input)
    result.gsub!(/_id\z/, "")
    result.gsub!(/_/, " ")
    result.capitalize!
    result
  end

  # Tabelize input string
  #
  # @param [String] input
  #
  # Create the name of a table like Rails does for models to table names.
  # This method # uses the +pluralize+ method on the last word in the string.
  #
  # @example
  #
  #   Inflecto.tabelize("RawScaledScorer") # => "raw_scaled_scorers"
  #   Inflecto.tabelize("egg_and_ham")     # => "egg_and_hams"
  #   Inflecto.tabelize("fancyCategory")   # => "fancy_categories"
  #
  # @return [String]
  #
  # @api private
  #
  def self.tableize(input)
    pluralize(underscore(input).gsub('/', '_'))
  end

  # Classify input
  #
  # Create a class name from a plural table name like Rails does for table names to models.
  # Note that this returns a string and not a Class.
  #
  # To convert to an actual class # follow +classify+ with +constantize+.
  #
  # @examples:
  #
  #   Inflecto.classify("egg_and_hams") # => "EggAndHam"
  #   Inflecto.classify("posts")        # => "Post"
  #
  #   # Singular names are not handled correctly:
  #   Inflecto.classify("business")     # => "Busines"
  #
  # @return [String]
  #
  # @api private
  #
  def self.classify(table_name)
    # strip out any leading schema name
    camelize(singularize(table_name.sub(/.*\./, '')))
  end

  # Test if word is uncountable
  #
  # @example
  #
  #   Inflecto.uncountable?('rice') #=> true
  #   Inflecto.uncountable?('apple') #=> false
  #
  # @param [String] word
  #
  # @return [Boolean]
  #   true, if word is uncountable
  #
  # @api private
  #
  def self.uncountable?(word)
    word.empty? || inflections.uncountables.include?(word.downcase)
  end
  private_class_method :uncountable?
end

require 'inflecto/rules_collection'
require 'inflecto/inflections'
require 'inflecto/defaults'
