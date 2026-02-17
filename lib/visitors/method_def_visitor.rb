# frozen_string_literal: true

module Lowkey
  class MethodDefVisitor
    attr_reader :parent_map

    def initialize(file_proxy:, parent_map:)
      @file_proxy = file_proxy
      @parent_map = parent_map
    end

    def visit(node)
      class_proxy = @file_proxy.upsert_class_proxy(node:, parent_map:)

      if ClassProxy.class_method?(node:, parent_map:)
        class_proxy.class_methods[node.name] = node
      else
        class_proxy.instance_methods[node.name] = node
      end
    end
  end
end
