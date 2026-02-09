# frozen_string_literal: true

class MethodDefVisitor
  def initialize(file_proxy:, parent_map:)
    @file_proxy = file_proxy
    @parent_map = parent_map
  end

  def visit(node)
    class_proxy = @file_proxy.class_proxy(node:)

    if class_proxy.class_method?(node:, parent_map:)
      class_proxy.class_methods[node.name] = node
    else
      class_proxy.instance_methods[node.name] = node
    end
  end
end
