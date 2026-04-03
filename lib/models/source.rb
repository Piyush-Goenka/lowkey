# frozen_string_literal: true

module Lowkey
  class WriteError < StandardError; end

  class Source
    attr_reader :file_path, :scope, :lines
    attr_accessor :start_line, :end_line

    def initialize(file_path:, scope:, lines:, start_line:, end_line: nil)
      @file_path = file_path
      @scope = scope

      @start_line = start_line
      @end_line = end_line
      @lines = lines
    end

    def lines=(new_lines)
      raise WriteError, "More new lines than old lines, won't fit" if new_lines.count > lines.count

      indent = lines[start_index][/^\s+/]

      [start_index..end_index].each do |line_index|
        lines[line_index] = indent + new_lines.pop.to_s || ''
      end
    end

    def wrap(prefix:, suffix:)
      start_line = lines[start_index]
      indent = start_line[/^\s+/]

      lines[start_index] = indent + prefix.to_s + start_line.lstrip
      lines[end_index] = lines[end_index] + suffix.to_s
    end

    def export
      lines[start_index..end_index].join
    end

    private

    def start_index
      start_line - 1
    end

    def end_index
      end_line - 1
    end
  end
end
