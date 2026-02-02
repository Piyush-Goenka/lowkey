# frozen_string_literal: true

module Lowkey
  class ParentMapper < Prism::Visitor
    attr_reader :parent_map

    def initialize
      @parent_map = {}
      @current_parent = nil
    end

    def visit(node)
      @parent_map[node] = @current_parent

      old_parent = @current_parent
      @current_parent = node

      node.compact_child_nodes.each do |n|
        visit(n)
      end

      @current_parent = old_parent
    end
  end
end
