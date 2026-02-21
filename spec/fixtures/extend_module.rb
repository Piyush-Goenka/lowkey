# frozen_string_literal: true

require_relative 'methods'

module Lowkey
  class ExtendModule
    extend Methods

    method_one
  end
end
