# frozen_string_literal: true

require 'prism'
require_relative '../../lib/lowkey'

RSpec.describe Lowkey::ParamProxy do
  subject(:file_proxy) { Lowkey.load('spec/fixtures/mock_node.rbx') }

  let(:method_proxy) { file_proxy['Lowkey::MockNode'][:render] }

  describe '#export' do
    context 'typed: true (default)' do
      it 'returns the raw source for a positional param' do
        param = method_proxy[:one]
        expect(param.export).to eq(param.export(typed: true))
      end

      it 'returns the raw source for a keyword param' do
        param = method_proxy[:three]
        expect(param.export).to eq(param.export(typed: true))
      end
    end

    context 'typed: false with a ValueExpression default' do
      # Simulates a LowType::ValueExpression without requiring LowType to be loaded
      let(:value_expression) do
        Struct.new(:value) { def class; Struct.new(:name) { }.new('LowType::ValueExpression') end }.new('hello')
      end

      let(:mock_expression) do
        double('expression', default_value: value_expression, required?: false)
      end

      it 'unwraps ValueExpression and uses .value as the default for positional param' do
        param = method_proxy[:two]
        param.expression = mock_expression
        expect(param.export(typed: false)).to eq('two = "hello"')
      end

      it 'unwraps ValueExpression and uses .value as the default for keyword param' do
        param = method_proxy[:four]
        param.expression = mock_expression
        expect(param.export(typed: false)).to eq('four: "hello"')
      end
    end

    context 'typed: false with no expression set' do
      it 'returns plain name for a required positional param' do
        param = method_proxy[:one]
        expect(param.export(typed: false)).to eq('one')
      end

      it 'returns plain name for a required keyword param' do
        param = method_proxy[:three]
        expect(param.export(typed: false)).to eq('three:')
      end

      it 'returns name with default for an optional positional param' do
        param = method_proxy[:two]
        expect(param.export(typed: false)).to eq("two = 'mock value'")
      end

      it 'returns name with default for an optional keyword param' do
        param = method_proxy[:four]
        expect(param.export(typed: false)).to eq("four: 'mock value'")
      end
    end
  end
end
