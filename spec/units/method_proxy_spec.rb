# frozen_string_literal: true

require 'prism'
require_relative '../../lib/proxies/method_proxy'

RSpec.describe Lowkey::MethodProxy do
  subject(:method_proxy) { described_class.new(file_path: 'mock/path', start_line: 123, scope: 'mock scope', name: 'mock name') }

  let(:method_node) do
    root_node = Prism.parse_file('spec/fixtures/mock_node.rb').value
    root_node.breadth_first_search { |n| n.instance_of?(Prism::MethodDefNode) }
  end
end
