# The Inflector transforms words from singular to plural, class names to table names, modularized class names to ones without,
# and class names to foreign keys. The default inflections for pluralization, singularization, and uncountable words are kept
# in inflections.rb.
#
# The Rails core team has stated patches for the inflections library will not be accepted
# in order to avoid breaking legacy applications which may be relying on errant inflections.
# If you discover an incorrect inflection and require it for your application, you'll need
# to correct it yourself (explained below).
module Inflector

  # Convert input to UpperCamelCase
  #
  # Will also convert '/' to '::' which is useful for converting paths to namespaces.
  #
  # @param [String] input
  #
  # @example
  #   Inflector.camelize("data_mapper")        # => "DataMapper"
  #   Inflector.camelize("data_mapper/errors") # => "DataMApper::Errors"
  #
  # @return [String]
  # 
  # @api public
  #
  def self.camelize(input)
    input.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
  end

  # Convert input to underscored, lowercase string 
  #
  # Changes '::' to '/' to convert namespaces to paths.
  #
  # @param [String] input
  #
  # @example
  #   Inflector.underscore("DataMapper")         # => "data_mapper"
  #   Inflector.underscore("DataMapper::Errors") # => "data_mapper/errors"
  #
  # @return [String]
  #
  # @api public
  #
  def self.underscore(input)
    word = input.to_s.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

  # Convert input underscores to dashes 
  #
  # @param [String] input
  #
  # @example
  #   Inflector.dasherize("foo_bar") # => "foo-bar"
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
  #   Inflector.demodulize("DataMapper::Error") # => "Error"
  #   Inflector.demodulize("DataMapper")        # => "DataMapper"
  #
  # @return [String]
  #
  # @api public
  #
  def self.demodulize(input)
    input.to_s.gsub(/^.*::/, '')
  end

  # Creates a foreign key name 
  #
  # @param [String] input
  #
  # @example
  #
  #   Inflector.foreign_key("Message) => "message_id"
  #
  # @return [String]
  #
  # @api private
  #
  def self.foreign_key(input)
    "#{underscore(demodulize(input))}_id"
  end

  # Find a constant with the name specified in the argument string
  #
  # The name is assumed to be the one of a top-level constant, constant scope of caller is igored
  #
  # @param [String] input
  #
  # @example
  #
  #   Inflector.constantize("Module")            # => Module
  #   Inflector.constantize("DataMapper::Error") # => Test::Unit
  #
  # @return [Class, Module]
  #
  # @api private
  #
  def self.constantize(input)
    names = input.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      # Ruby 1.9 introduces an inherit argument for Module#const_get and
      # #const_defined? and changes their default behavior.
      if Module.method(:const_get).arity == 1
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      else
        constant = constant.const_defined?(name, false) ? constant.const_get(name) : constant.const_missing(name)
      end
    end
    constant
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
    if (11..13).include?(number.to_i % 100)
      "#{number}th"
    else
      case number.to_i % 10
        when 1; "#{number}st"
        when 2; "#{number}nd"
        when 3; "#{number}rd"
        else    "#{number}th"
      end
    end
  end

  # Yields a singleton instance of Inflector::Inflections 
  #
  # @example
  #
  #   Inflector.inflections do |inflect|
  #     inflect.uncountable "rails"
  #   end
  #
  # @return [Inflector::Inflections]
  #
  # @api public
  #
  def self.inflections
    if block_given?
      yield Inflections.instance
    else
      Inflections.instance
    end
  end

  # Convert input word string to plural 
  #
  # @param [String] word
  #
  # @example
  #
  #   Inflector.pluralize("post")         # => "posts"
  #   Inflector.pluralize("octopus")      # => "octopi"
  #   Inflector.pluralize("sheep")        # => "sheep"
  #   Inflector.pluralize("words")        # => "words"
  #   Inflector.pluralize("CamelOctopus") # => "CamelOctopi"
  #
  # @return [String]
  #
  # @api public
  #
  def self.pluralize(word)
    result = word.to_s.dup

    if result.empty? || inflections.uncountables.include?(result.downcase)
      result
    else
      inflections.plurals.each { |(rule, replacement)| break if result.gsub!(rule, replacement) }
      result
    end
  end

  # Convert word to singular
  #
  # @param [String] word
  #
  # @example
  #
  #   Inflector.singularize("posts") # => "post"
  #   Inflector.singularize("octopi") # => "octopus"
  #   Inflector.singularize("sheep") # => "sheep"
  #   Inflector.singularize("word") # => "word"
  #   Inflector.singularize("CamelOctopi") # => "CamelOctopus"
  #
  # @return [String]
  #
  # @api public
  #
  def self.singularize(word)
    result = word.to_s.dup

    if inflections.uncountables.any? { |inflection| result =~ /\b(#{inflection})\Z/i }
      result
    else
      inflections.singulars.each { |(rule, replacement)| break if result.gsub!(rule, replacement) }
      result
    end
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
  #   Inflector.humanize("employee_salary") # => "Employee salary"
  #   Inflector.humanize("author_id")       # => "Author"
  #
  # @return [String]
  #
  # @api private
  #
  def self.humanize(input)
    result = input.to_s.dup

    inflections.humans.each { |(rule, replacement)| break if result.gsub!(rule, replacement) }
    result.gsub(/_id$/, "").gsub(/_/, " ").capitalize
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
  #   Inflector.tabelize("RawScaledScorer") # => "raw_scaled_scorers"
  #   Inflector.tabelize("egg_and_ham")     # => "egg_and_hams"
  #   Inflector.tabelize("fancyCategory")   # => "fancy_categories"
  #
  # @return [String]
  #
  # @api private
  #
  def self.tableize(input)
    pluralize(underscore(input).gsub('/','_'))
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
  #   Inflector.classify("egg_and_hams") # => "EggAndHam"
  #   Inflector.classify("posts")        # => "Post"
  #
  #   # Singular names are not handled correctly:
  #   Inflector.classify("business")     # => "Busines"
  #
  # @return [String]
  #
  # @api private
  #
  def self.classify(table_name)
    # strip out any leading schema name
    camelize(singularize(table_name.to_s.sub(/.*\./, '')))
  end

end

require 'inflector/inflections'
require 'inflector/defaults'
