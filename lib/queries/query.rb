# frozen_string_literal: true

module Lowkey
  module Query
    # TODO: Make name a keypath.
    def query(node:, namespace:, name:) # rubocop:disable Lint/UnusedMethodArgument
      node.breadth_first_search do |n|
        n.respond_to?(:name) && n.name == name.to_sym
      end
    end

    def namespace(node:, parent_map:, namespace: [])
      if parent_map[node].nil?
        namespace << 'Object' if namespace.empty?
        return namespace.reverse.join('::')
      end

      namespace << node.constant_path.name.to_s if node.respond_to?(:constant_path)

      namespace(node: parent_map[node], parent_map:, namespace:)
    end
  end
end
