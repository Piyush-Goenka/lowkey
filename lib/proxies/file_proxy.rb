# frozen_string_literal: true

require_relative '../maps/parent_map'
require_relative '../proxies/class_proxy'

module Lowkey
  class FileProxy
    attr_reader :path, :start_line, :end_line, :definitions, :dependencies

    def initialize(path:, root_node:)
      @path = path
      @start_line = 0
      @end_line = root_node.respond_to?(:end_line) ? root_node.end_line : nil

      @definitions = {}
      @dependencies = []
    end

    def class_proxy(node:)
      @definitions[node.name] ||= ClassProxy.new(node:, file_proxy: self)
    end
  end
end
