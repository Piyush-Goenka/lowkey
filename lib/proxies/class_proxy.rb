# frozen_string_literal: true

require 'forwardable'

module Lowkey
  class ClassProxy
    attr_reader :class_name, :file_proxy, :start_line, :end_line
    attr_accessor :private_start_line, :class_methods, :instance_methods, :method_calls

    def initialize(node:, file_proxy:)
      @class_name = node.name
      @file_proxy = file_proxy

      @start_line = node.class_keyword_loc.start_line
      @end_line = node.end_keyword_loc.end_line # class_keyword_loc ?
      @private_start_line = nil

      @class_methods = {}
      @instance_methods = {}
      @method_calls = []
    end

    private

    def class_method?(node)
      return true if node.is_a?(::Prism::DefNode) && node.receiver.instance_of?(Prism::SelfNode) # self.method_name
      return true if node.is_a?(::Prism::SingletonClassNode) # class << self

      if (parent_node = parent_map.parent(node:))
        return class_method?(parent_node)
      end

      false
    end
  end
end
