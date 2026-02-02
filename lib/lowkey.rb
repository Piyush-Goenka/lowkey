# frozen_string_literal: true

require 'prism'
require_relative 'ast'

module Lowkey
  class << self
    def parse(file_path)
      root_node = Prism.parse_file(file_path).value
      klass = Object # TODO.
      AST.new(root_node:, klass:, file_path:)
    end
  end
end
