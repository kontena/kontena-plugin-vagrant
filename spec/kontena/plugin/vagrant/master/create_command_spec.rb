require 'spec_helper'
require 'kontena/plugin/vagrant_command'

describe Kontena::Plugin::Vagrant::Master::CreateCommand do

  let(:subject) do
    described_class.new(File.basename($0))
  end

  let(:provisioner) do
    spy(:provisioner)
  end

  describe '#run' do

    it 'passes options to provisioner' do
      options = [
        '--name', 'my-custom-name',
        '--memory', '1024',
        '--no-prompt',
        '--skip-auth-provider'
      ]
      expect(subject).to receive(:provisioner).and_return(provisioner)
      expect(provisioner).to receive(:run!).with(
        hash_including(memory: '1024', name: 'my-custom-name')
      )
      subject.run(options)
    end
  end
end
