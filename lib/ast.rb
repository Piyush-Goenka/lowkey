# frozen_string_literal: true

require_relative 'proxies/class_proxy'
require_relative 'visitors/method_call_visitor'
require_relative 'visitors/method_def_visitor'
require_relative 'visitors/parent_mapper'

module Lowkey
  class AST
    attr_reader :parent_map, :instance_methods, :class_methods, :class_proxy

    def initialize(root_node:, klass:, file_path:)
      @root_node = root_node

      parent_mapper = ParentMapper.new
      parent_mapper.visit(@root_node)
      @parent_map = parent_mapper.parent_map

      method_visitor = MethodDefVisitor.new(root_node: @root_node, parent_map:, klass:, file_path:)
      @root_node.accept(method_visitor)

      @instance_methods = method_visitor.instance_methods
      @class_methods = method_visitor.class_methods
      @class_proxy = ClassProxy.new(klass:, file: method_visitor.file_proxy, private_start_line: method_visitor.private_start_line)
    end

    def method_calls(method_names:)
      block_visitor = MethodCallVisitor.new(parent_map:, method_names:)
      @root_node.accept(block_visitor)
      block_visitor.method_calls
    end
  end
end
