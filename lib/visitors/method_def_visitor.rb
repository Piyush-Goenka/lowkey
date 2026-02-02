# frozen_string_literal: true

require_relative '../proxies/file_proxy'

module Lowkey
  class MethodDefVisitor < Prism::Visitor
    attr_reader :class_methods, :instance_methods, :file_proxy, :private_start_line

    def initialize(root_node:, parent_map:, klass:, file_path:)
      @parent_map = parent_map
      @klass = klass

      @instance_methods = {}
      @class_methods = {}

      end_line = root_node.respond_to?(:end_line) ? root_node.end_line : nil
      @file_proxy = FileProxy.new(path: file_path, start_line: 0, end_line:, scope: klass.to_s)
      @private_start_line = nil
    end

    def visit_def_node(node)
      if class_method?(node)
        @class_methods[node.name] = node
      else
        @instance_methods[node.name] = node
      end

      super # Continue walking the tree.
    end

    def visit_call_node(node)
      return super unless node.name == :private && node.respond_to?(:start_line) && file_proxy.start_line && file_proxy.end_line

      @private_start_line = node.start_line if node.start_line > file_proxy.start_line && node.start_line < file_proxy.end_line

      super
    end

    def visit_class_node(node)
      if node.name == @klass.to_s.to_sym
        file_proxy.start_line = node.class_keyword_loc.start_line
        file_proxy.end_line = node.end_keyword_loc.end_line
      end

      super
    end

    private

    def class_method?(node)
      return true if node.is_a?(::Prism::DefNode) && node.receiver.instance_of?(Prism::SelfNode) # self.method_name
      return true if node.is_a?(::Prism::SingletonClassNode) # class << self

      if (parent_node = @parent_map[node])
        return class_method?(parent_node)
      end

      false
    end
  end
end
