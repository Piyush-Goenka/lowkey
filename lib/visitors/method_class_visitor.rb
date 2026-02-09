# frozen_string_literal: true

class MethodClassVisitor
  def initialize(file_proxy:)
    @file_proxy = file_proxy
  end

  def visit(node)
    class_proxy = @file_proxy.class_proxy(node:)
  end
end
