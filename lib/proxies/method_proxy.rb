# frozen_string_literal: true

require_relative '../interfaces/proxy'
require_relative '../queries/query'

module Lowkey
  class MethodProxy < Proxy
    include Query

    attr_reader :file_path, :start_line, :scope, :name, :return_proxy
    attr_reader :params, :required_params, :optional_params, :positional_params, :keyword_params

    # TODO: Refactor file path, start line and scope into "scope" model.
    def initialize(file_path:, start_line:, scope:, name:, param_proxies: [], return_proxy: nil) # rubocop:disable Metrics/ParameterLists
      super(file_path:, start_line:, scope:)

      @name = name

      @params = param_proxies
      @required_params = []
      @optional_params = []
      @positional_params = []
      @keyword_params = []
      @named_params = {}

      @return_proxy = return_proxy

      @params.each do |param|
        next unless [:pos_req, :pos_opt, :key_req, :key_opt].include?(param.type)

        @required_params << param if [:pos_req, :key_req].include?(param.type)
        @optional_params << param if [:pos_opt, :key_opt].include?(param.type)
        @positional_params << param if [:pos_req, :pos_opt].include?(param.type)
        @keyword_params << param if [:key_req, :key_opt].include?(param.type)

        @named_params[param.name] = param
      end
    end

    def [](key)
      # TODO: Initialize method proxy with method node and support query code path.
      key.start_with?('.') ? query(node: @node, namespace: nil, name: key.delete_prefix('.')) : @named_params[key]
    end
  end
end
