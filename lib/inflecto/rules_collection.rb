module Inflecto
  # Wraps inflections array
  #
  class RulesCollection < Array
    # Applies first found rule to given word
    #
    # @param [String] word
    #
    # @return [String]
    #   modified word
    #
    # @api private
    #
    def apply_to(word)
      result = word.dup
      each { |rule, replacement| break if result.gsub!(rule, replacement) }
      result
    end
  end
end
