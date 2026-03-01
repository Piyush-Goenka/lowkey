# frozen_string_literal: true

require_relative '../interfaces/proxy'

module Lowkey
  class ReturnProxy < Proxy
    attr_reader :name, :value
    attr_accessor :expression

    def initialize(file_path:, start_line:, scope:, name:, value:)
      super(file_path:, start_line:, scope:)

      @name = name
      @value = value

      @expression = nil
    end
  end
end
