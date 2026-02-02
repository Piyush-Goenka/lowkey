# frozen_string_literal: true

module Lowkey
  class MethodCallVisitor < Prism::Visitor
    attr_reader :method_calls

    def initialize(parent_map:, method_names:)
      @parent_map = parent_map
      @method_names = method_names

      @method_calls = []
    end

    def visit_call_node(node)
      @method_calls << node if @method_names.include?(node.name)

      super # Continue walking the tree.
    end
  end
end
