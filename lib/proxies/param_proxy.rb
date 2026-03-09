# frozen_string_literal: true

require_relative '../interfaces/proxy'

module Lowkey
  class ParamProxy < Proxy
    attr_reader :type, :position, :value
    attr_accessor :expression

    def initialize(scope:, name:, type:, value: :LOWKEY_UNDEFINED, position: nil, expression: nil) # rubocop:disable Metrics/ParameterLists
      super(scope:, name:)

      @type = type
      @position = position
      @value = value
      @expression = expression
    end

    def required?
      @value == :LOWKEY_UNDEFINED
    end
  end
end
