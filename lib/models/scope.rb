# frozen_string_literal: true

module Lowkey
  class Scope
    attr_reader :file_path, :scope
    attr_accessor :start_line, :end_line

    def initialize(file_path:, scope:, start_line:, end_line: nil)
      @file_path = file_path
      @scope = scope
      @start_line = start_line
      @end_line = end_line
    end
  end
end
