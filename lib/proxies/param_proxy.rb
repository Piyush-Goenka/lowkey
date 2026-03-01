# frozen_string_literal: true

require_relative '../interfaces/proxy'

module Lowkey
  class ParamProxy < Proxy
    attr_reader :name, :type, :position, :default_value
    attr_accessor :expression

    # TODO: Refactor file path, start line and scope into "scope" model.
    def initialize(file_path:, start_line:, scope:, name:, type:, position: nil, default_value: nil) # rubocop:disable Metrics/ParameterLists
      super(file_path:, start_line:, scope:)

      @name = name
      @type = type
      @position = position

      @default_value = default_value
      @expression = nil
    end

    # TODO. Use PRISM.
    def required?
      @expression.required?
    end
  end
end
