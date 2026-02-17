# frozen_string_literal: true

module Lowkey
  class MethodCallVisitor
    attr_reader :parent_map

    def initialize(file_proxy:, parent_map:)
      @file_proxy = file_proxy
      @parent_map = parent_map
    end

    def visit(node)
      class_proxy = @file_proxy.class_proxy(node:, parent_map:)
      class_proxy.method_calls << node

      return unless node.name == :private && node.respond_to?(:start_line) && class_proxy.start_line && class_proxy.end_line
      return unless node.start_line > class_proxy.start_line && node.start_line < class_proxy.end_line

      class_proxy.private_start_line = node.start_line
    end
  end
end
