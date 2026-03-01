# frozen_string_literal: true

require_relative '../interfaces/proxy'
require_relative '../queries/query'

module Lowkey
  class MethodProxy < Proxy
    include Query

    attr_reader :file_path, :start_line, :scope, :name, :params, :return_proxy

    # TODO: Refactor file path, start line and scope into "scope" model.
    def initialize(file_path:, start_line:, scope:, name:, param_proxies: [], return_proxy: nil) # rubocop:disable Metrics/ParameterLists
      super(file_path:, start_line:, scope:)

      @name = name
      @params = param_proxies
      @named_params = name_params
      @sorted_params = sort_params
      @return_proxy = return_proxy
    end

    def [](key)
      # TODO: Initialize method proxy with method node and support query code path.
      key.start_with?('.') ? query(node: @node, namespace: nil, name: key.delete_prefix('.')) : @named_params[key]
    end

    def sorted_params(sorting)
      @sorted_params[sorting]
    end

    def expressions?
      @params.any?(&:expression)
    end

    private

    def name_params
      @params.each_with_object({}) do |param, named_params|
        named_params[param.name] = param if %i[pos_req pos_opt key_req key_opt].include?(param.type)
      end
    end

    def sort_params
      sorting = { required: [], optional: [], positional: [], keyword: [] }

      @params.each do |param|
        sorting[:required] << param if %i[pos_req key_req].include?(param.type)
        sorting[:optional] << param if %i[pos_opt key_opt].include?(param.type)
        sorting[:positional] << param if %i[pos_req pos_opt].include?(param.type)
        sorting[:keyword] << param if %i[key_req key_opt].include?(param.type)
      end

      sorting
    end
  end
end
