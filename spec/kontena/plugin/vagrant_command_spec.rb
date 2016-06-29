require 'spec_helper'
require 'kontena/plugin/vagrant_command'

describe Kontena::Plugin::VagrantCommand do

  let(:subject) do
    described_class.new(File.basename($0))
  end

  describe '#run' do
    it 'raises help wanted by default' do
      expect {
        subject.run([])
      }.to raise_error(Clamp::HelpWanted)
    end

    it 'raises help wanted for master' do
      expect {
        subject.run(['master'])
      }.to raise_error(Clamp::HelpWanted)
    end

    it 'raises help wanted for node' do
      expect {
        subject.run(['node'])
      }.to raise_error(Clamp::HelpWanted)
    end

    it 'raises usage error otherwise' do
      expect {
        subject.run(['unknown'])
      }.to raise_error(Clamp::UsageError)
    end
  end
end
