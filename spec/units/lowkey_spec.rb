# frozen_string_literal: true

require_relative '../../lib/lowkey'
require_relative '../../lib/proxies/file_proxy'

RSpec.describe Lowkey do
  let(:file_path) { 'spec/fixtures/a.rb' }

  describe '.load' do
    let(:file_proxy) { Lowkey.load(file_path:) }

    it 'loads file' do
      expect(file_proxy).to be_an_instance_of(Lowkey::FileProxy)
    end
  end

  describe '.[]' do
    let(:file_proxy) { Lowkey.load(file_path:) }

    it 'maps file path to file proxy' do
      expect(Lowkey['spec/fixtures/a.rb']).to be_an_instance_of(Lowkey::FileProxy)
    end

    it 'maps namespace to file proxies' do
      expect(Lowkey['Lowkey::A'].first).to be_an_instance_of(Lowkey::FileProxy)
    end
  end
end
