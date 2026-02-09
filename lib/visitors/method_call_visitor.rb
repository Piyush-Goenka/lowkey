# frozen_string_literal: true

class MethodCallVisitor
  def initialize(file_proxy:)
    @file_proxy = file_proxy
  end

  def visit(node)
    class_proxy = @file_proxy.class_proxy(node:)
    class_proxy.method_calls << node

    if node.name == :private && node.respond_to?(:start_line) && class_proxy.start_line && class_proxy.end_line
      if node.start_line > class_proxy.start_line && node.start_line < class_proxy.end_line
        class_proxy.private_start_line = node.start_line 
      end
    end

  end
end
