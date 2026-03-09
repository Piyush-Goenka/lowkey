# frozen_string_literal: true

require 'forwardable'

module Lowkey
  class Proxy
    extend Forwardable

    attr_reader :name

    def_delegator :@scope, :file_path
    def_delegator :@scope, :start_line
    def_delegator :@scope, :scope

    def initialize(name:, scope:)
      @name = name
      @scope = scope
    end
  end
end
