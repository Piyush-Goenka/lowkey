# frozen_string_literal: true

require_relative '../proxies/class_proxy'
require_relative '../queries/query'

module Lowkey
  class FileProxy
    include Query

    attr_reader :root_node, :file_path, :start_line, :end_line
    attr_accessor :definitions, :dependencies

    def initialize(file_path:, root_node:)
      @file_path = file_path
      @root_node = root_node

      @start_line = 0
      @end_line = root_node.respond_to?(:end_line) ? root_node.end_line : nil

      @definitions = {}
      @dependencies = []
    end

    def [](keypath)
      namespace, *file_path = keypath.split('.')
      file_path.empty? ? @definitions[namespace] : query(node: @root_node, namespace:, name: file_path.join)
    end

    def []=(keypath, value)
      # TODO: Slice the lines in a file and replace with the output of the class proxy.
    end

    def upsert_class_proxy(class_proxy:)
      # TODO: Merge duplicate class with existing class.
      @definitions[class_proxy.namespace] ||= class_proxy
    end
  end
end
