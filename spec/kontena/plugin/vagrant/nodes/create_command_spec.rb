require 'spec_helper'
require 'kontena/plugin/vagrant_command'

describe Kontena::Plugin::Vagrant::Nodes::CreateCommand do

  let(:subject) do
    described_class.new(File.basename($0))
  end

  let(:provisioner) do
    spy(:provisioner)
  end

  let(:client) do
    spy(:client)
  end

  describe '#run' do
    before(:each) do
      allow(subject).to receive(:require_api_url).and_return('https://localhost')
      allow(subject).to receive(:require_token).and_return('foo')
      allow(subject).to receive(:require_current_grid).and_return('test-grid')
      allow(subject).to receive(:fetch_grid).and_return({})
      allow(subject).to receive(:client).and_return(client)
    end

    it 'passes options to provisioner' do
      options = [
        '--memory', '1024', '--instances', '1'
      ]
      expect(subject).to receive(:provisioner).with(client).and_return(provisioner)
      expect(provisioner).to receive(:run!).with(
        hash_including(memory: '1024')
      )
      subject.run(options)
    end
  end
end
