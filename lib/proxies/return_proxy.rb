# frozen_string_literal: true

require_relative '../interfaces/proxy'

module Lowkey
  class ReturnProxy < Proxy
    attr_reader :value
    attr_accessor :expression

    def initialize(name:, scope:, value: :LOWKEY_UNDEFINED, expression: nil)
      super(name:, scope:)

      @value = value
      @expression = expression
    end
  end
end
