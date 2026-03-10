# frozen_string_literal: true

require 'forwardable'

module Lowkey
  # Proxy and Source abstract away nodes and avoid referencing the node on the proxy itself. Will this change?
  # The goal is to make an API that's indiependent of the AST, that can manipulate source code line by line.
  class Proxy
    extend Forwardable

    attr_reader :name

    def_delegator :@source, :file_path
    def_delegator :@source, :lines
    def_delegator :@source, :start_line
    def_delegator :@source, :scope

    def initialize(name:, source:)
      @name = name
      @source = source
    end
  end
end
