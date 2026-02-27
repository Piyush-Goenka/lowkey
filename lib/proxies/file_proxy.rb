# frozen_string_literal: true

require_relative '../maps/parent_map'
require_relative '../proxies/class_proxy'
require_relative '../queries/query'

module Lowkey
  class FileProxy
    include Query

    attr_reader :path, :start_line, :end_line
    attr_accessor :definitions, :dependencies

    def initialize(path:, root_node:)
      @path = path
      @root_node = root_node

      @start_line = 0
      @end_line = root_node.respond_to?(:end_line) ? root_node.end_line : nil

      @definitions = {}
      @dependencies = []
    end

    def [](keypath)
      namespace, *path = keypath.split('.')
      path.empty? ? @definitions[namespace] : query(node: @root_node, namespace:, name: path.join)
    end

    def []=(keypath, value)
      # TODO: Slice the lines in a file and replace with the output of the class proxy.
    end

    def upsert_class_proxy(node:, parent_map:)
      namespace = namespace(node:, parent_map:).reverse.join('::')
      namespace = 'Object' if namespace.empty?
      @definitions[namespace] ||= ClassProxy.new(node:, namespace:, file_proxy: self)
    end

    private

    def namespace(node:, parent_map:, namespace: [])
      return namespace if parent_map[node].nil?

      namespace << node.constant_path.name.to_s if node.respond_to?(:constant_path)

      namespace(node: parent_map[node], parent_map:, namespace:)
    end
  end
end
