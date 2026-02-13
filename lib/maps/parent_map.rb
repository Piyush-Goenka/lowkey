# frozen_string_literal: true

module Lowkey
  class ParentMap
    def initialize(root_node:)
      @parent_map = {}
      @current_parent = nil

      map(root_node)
    end

    def [](node)
      @parent_map[node]
    end

    private

    def map(node)
      @parent_map[node] = @current_parent

      old_parent = @current_parent
      @current_parent = node

      node.compact_child_nodes.each do |n|
        map(n)
      end

      @current_parent = old_parent
    end
  end
end
