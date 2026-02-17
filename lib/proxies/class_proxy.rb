# frozen_string_literal: true

require 'forwardable'

module Lowkey
  class ClassProxy
    attr_reader :namespace, :file_proxy, :start_line, :end_line
    attr_writer :method_calls
    attr_accessor :private_start_line, :class_methods, :instance_methods

    def initialize(node:, namespace:, file_proxy:)
      @namespace = namespace
      @file_proxy = file_proxy

      @start_line = node.respond_to?(:class_keyword_loc) ? node.class_keyword_loc.start_line : 0
      @end_line = node.respond_to?(:end_keyword_loc) ? node.end_keyword_loc.end_line : 0
      @private_start_line = nil

      @class_methods = {}
      @instance_methods = {}
      @method_calls = []
    end

    def method_calls(method_names = nil)
      return @method_calls if method_names.nil?

      @method_calls.filter { |method_call| method_names.include?(method_call.name) }
    end

    class << self
      # Only a lambda defined immediately after a method's parameters/block is considered a return type expression.
      def return_type(method_node:)
        # Method statements.
        statements_node = method_node.compact_child_nodes.find { |node| node.is_a?(Prism::StatementsNode) }

        # Block statements.
        if statements_node.nil?
          block_node = method_node.compact_child_nodes.find { |node| node.is_a?(Prism::BlockNode) }
          statements_node = block_node.compact_child_nodes.find { |node| node.is_a?(Prism::StatementsNode) } if block_node
        end

        return nil if statements_node.nil? # Sometimes developers define methods without code inside them.

        node = statements_node.body.first
        return node if node.is_a?(Prism::LambdaNode)

        nil
      end

      def class_method?(node:, parent_map:)
        return true if node.is_a?(::Prism::DefNode) && node.receiver.instance_of?(Prism::SelfNode) # self.method_name
        return true if node.is_a?(::Prism::SingletonClassNode) # class << self

        if (parent_node = parent_map[node])
          return class_method?(node: parent_node, parent_map:)
        end

        false
      end
    end
  end
end
