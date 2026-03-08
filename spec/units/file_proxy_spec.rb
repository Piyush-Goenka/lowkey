# frozen_string_literal: true

require 'prism'

require_relative '../../lib/lowkey'
require_relative '../../lib/proxies/class_proxy'
require_relative '../../lib/proxies/file_proxy'
require_relative '../../lib/proxies/method_proxy'
require_relative '../../lib/proxies/param_proxy'
require_relative '../../lib/proxies/return_proxy'

RSpec.describe Lowkey::FileProxy do
  subject(:file_proxy) { Lowkey.load('spec/fixtures/mock_node.rb') }

  describe '.[]' do
    it 'returns a class proxy' do
      expect(file_proxy['Lowkey::MockNode']).to be_an_instance_of(Lowkey::ClassProxy)
    end

    it 'returns a method proxy' do
      expect(file_proxy['Lowkey::MockNode'][:render]).to be_an_instance_of(Lowkey::MethodProxy)
    end

    it 'returns a param proxy' do
      expect(file_proxy['Lowkey::MockNode'][:render][:one]).to be_an_instance_of(Lowkey::ParamProxy)
    end

    it 'returns a return proxy' do
      expect(file_proxy['Lowkey::MockNode'][:render].return_proxy).to be_an_instance_of(Lowkey::ReturnProxy)
    end

    it 'returns a method node' do
      expect(file_proxy['Lowkey::MockNode.render']).to be_an_instance_of(Prism::DefNode)
    end
  end
end
