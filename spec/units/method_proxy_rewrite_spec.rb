# frozen_string_literal: true

require 'prism'
require_relative '../../lib/lowkey'

RSpec.describe Lowkey::MethodProxy do
  subject(:file_proxy) { Lowkey.load('spec/fixtures/mock_node.rbx') }

  let(:method_proxy) { file_proxy['Lowkey::MockNode'][:render] }

  describe '#rewrite_signature' do
    it 'replaces the signature line in the shared lines array' do
      original_line = method_proxy.lines[method_proxy.start_line - 1].dup
      method_proxy.rewrite_signature
      rewritten = method_proxy.lines[method_proxy.start_line - 1]
      expect(rewritten).not_to eq(original_line)
    end

    it 'removes type annotations from the signature' do
      method_proxy.rewrite_signature
      rewritten = method_proxy.lines[method_proxy.start_line - 1]
      expect(rewritten).not_to match(/String|Integer|Symbol/)
    end

    it 'preserves the method name' do
      method_proxy.rewrite_signature
      rewritten = method_proxy.lines[method_proxy.start_line - 1]
      expect(rewritten).to include('def render')
    end

    it 'is reflected in file_proxy.export since lines are shared' do
      method_proxy.rewrite_signature
      expect(file_proxy.export).to include(method_proxy.lines[method_proxy.start_line - 1].strip)
    end
  end
end
