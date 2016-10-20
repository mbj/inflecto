require 'inflecto'

module Inflecto
  module Refinements
    refine String do
      # Convert self to UpperCamelCase
      #
      # Will also convert '/' to '::' which is useful for converting paths to namespaces.
      #
      # @example
      #   "data_mapper".camelize        # => "DataMapper"
      #   "data_mapper/errors".camelize # => "DataMapper::Errors"
      #
      # @return [String]
      #
      # @api public
      #
      def camelize
        Inflecto.camelize(self)
      end

      # Convert self to underscored, lowercase string
      #
      # Changes '::' to '/' to convert namespaces to paths.
      #
      # @example
      #   "DataMapper".underscore         # => "data_mapper"
      #   "DataMapper::Errors".underscore # => "data_mapper/errors"
      #
      # @return [String]
      #
      # @api public
      #
      def underscore
        Inflecto.underscore(self)
      end

      # Convert self underscores to dashes
      #
      # @example
      #   "foo_bar".dasherize # => "foo-bar"
      #
      # @return [String]
      #
      # @api public
      #
      def dasherize
        Inflecto.dasherize(self)
      end

      # Return unscoped constant name
      #
      # @example
      #
      #   "DataMapper::Error".demodulize # => "Error"
      #   "DataMapper".demodulize        # => "DataMapper"
      #
      # @return [String]
      #
      # @api public
      #
      def demodulize
        Inflecto.demodulize(self)
      end

      # Creates a foreign key name
      #
      # @example
      #
      #   "Message".foreign_key => "message_id"
      #
      # @return [String]
      #
      # @api public
      #
      def foreign_key
        Inflecto.foreign_key(self)
      end

      # Find a constant with the name specified in the argument string
      #
      # The name is assumed to be the one of a top-level constant, constant scope of caller is ignored
      #
      # @example
      #
      #   "Module".constantize            # => Module
      #   "DataMapper::Error".constantize # => DataMapper::Error
      #
      # @return [Class, Module]
      #
      # @api public
      #
      def constantize
        Inflecto.constantize(self)
      end

      # Convert self word string to plural
      #
      # @example
      #
      #   "post".pluralize         # => "posts"
      #   "octopus".pluralize      # => "octopi"
      #   "sheep".pluralize        # => "sheep"
      #   "words".pluralize        # => "words"
      #   "CamelOctopus".pluralize # => "CamelOctopi"
      #
      # @return [String]
      #
      # @api public
      #
      def pluralize
        Inflecto.pluralize(self)
      end

      # Convert word to singular
      #
      # @example
      #
      #   "posts".singularize # => "post"
      #   "octopi".singularize # => "octopus"
      #   "sheep".singularize # => "sheep"
      #   "word".singularize # => "word"
      #   "CamelOctopi".singularize # => "CamelOctopus"
      #
      # @return [String]
      #
      # @api public
      #
      def singularize
        Inflecto.singularize(self)
      end

      # Humanize string
      #
      # capitalizes the first word and turns underscores into spaces and strips a # trailing "_id", if any.
      # Like +titleize+, this is meant for creating pretty output.
      #
      # @example
      #
      #   "employee_salary".humanize # => "Employee salary"
      #   "author_id".humanize       # => "Author"
      #
      # @return [String]
      #
      # @api public
      #
      def humanize
        Inflecto.humanize(self)
      end

      # Tableize string
      #
      # Create the name of a table like Rails does for models to table names.
      # This method # uses the +pluralize+ method on the last word in the string.
      #
      # @example
      #
      #   "RawScaledScorer".tableize # => "raw_scaled_scorers"
      #   "egg_and_ham".tableize     # => "egg_and_hams"
      #   "fancyCategory".tableize   # => "fancy_categories"
      #
      # @return [String]
      #
      # @api public
      #
      def tableize
        Inflecto.tableize(self)
      end

      # Classify self
      #
      # Create a class name from a plural table name like Rails does for table names to models.
      # Note that this returns a string and not a Class.
      #
      # To convert to an actual class # follow +classify+ with +constantize+.
      #
      # @examples:
      #
      #   "egg_and_hams".classify # => "EggAndHam"
      #   "posts".classify        # => "Post"
      #
      #   # Singular names are not handled correctly:
      #   "business".classify     # => "Busines"
      #
      # @return [String]
      #
      # @api public
      #
      def classify
        Inflecto.classify(self)
      end

      # Test if word is uncountable
      #
      # @example
      #
      #   'rice'.uncountable? #=> true
      #   'apple'.uncountable? #=> false
      #
      # @return [Boolean]
      #   true, if word is uncountable
      #
      # @api public
      #
      def uncountable?
        Inflecto.uncountable?(self)
      end
    end
    
    refine Numeric do
      # Convert a number into an ordinal string
      #
      # @example
      #
      #   1.ordinalize     # => "1st"
      #   2.ordinalize     # => "2nd"
      #   1002.ordinalize  # => "1002nd"
      #   1003.ordinalize  # => "1003rd"
      #
      # @return [String]
      #
      # @api public
      #
      def ordinalize
        Inflecto.ordinalize(self)
      end
    end
  end
end
