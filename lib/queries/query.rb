# frozen_string_literal: true

module Lowkey
  module Query
    # TODO: Make name a keypath.
    def query(node:, namespace:, name:) # rubocop:disable Lint/UnusedMethodArgument
      node.breadth_first_search do |n|
        n.respond_to?(:name) && n.name == name.to_sym
      end
    end
  end
end
