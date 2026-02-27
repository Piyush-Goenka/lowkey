# frozen_string_literal: true

module Lowkey
  class MockNode
    def render(one, two = 'mock value', three:, four: 'mock value') -> { 'mock return type' }
      <<~HTML
        <p>Hello</p>
      HTML
    end
  end
end
