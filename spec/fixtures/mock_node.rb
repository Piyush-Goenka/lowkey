# frozen_string_literal: true

module Lowkey
  class MockNode
    def render
      <<~HTML
        <p>Hello</p>
      HTML
    end
  end
end
