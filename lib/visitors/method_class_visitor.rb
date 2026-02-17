# frozen_string_literal: true

module Lowkey
  class MethodClassVisitor
    attr_reader :parent_map

    def initialize(file_proxy:, parent_map:)
      @file_proxy = file_proxy
      @parent_map = parent_map
    end

    def visit(node)
      @file_proxy.class_proxy(node:, parent_map:)
    end
  end
end
