# frozen_string_literal: true

require_relative '../../lib/lowkey'
require_relative '../../lib/proxies/file_proxy'

RSpec.describe Lowkey do
  let(:file_path) { 'spec/fixtures/a.rb' }

  describe '.parse' do
    let(:file_proxy) { Lowkey.parse(file_path:) }

    it 'parses file' do
      expect(file_proxy).to be_an_instance_of(Lowkey::FileProxy)
    end
  end
end
