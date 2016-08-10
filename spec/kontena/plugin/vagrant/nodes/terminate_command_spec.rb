require 'spec_helper'
require 'kontena/plugin/vagrant_command'

describe Kontena::Plugin::Vagrant::Nodes::TerminateCommand do

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
      allow(subject).to receive(:client).and_return(client)
    end

    it 'raises usage error if no options are defined' do
      expect {
        subject.run([])
      }.to raise_error(Clamp::UsageError)
    end

    it 'passes options to provisioner' do
      options = ['--force', 'my-node']
      expect(subject).to receive(:destroyer).with(client).and_return(provisioner)
      expect(provisioner).to receive(:run!)
      subject.run(options)
    end

    it 'asks confirmation without force' do
      options = ['my-node']
      expect(subject).to receive(:confirm_command)
      allow(subject).to receive(:destroyer).with(client).and_return(provisioner)
      subject.run(options)
    end
  end
end
