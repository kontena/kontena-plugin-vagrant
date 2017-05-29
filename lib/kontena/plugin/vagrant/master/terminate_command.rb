module Kontena::Plugin::Vagrant::Master
  class TerminateCommand < Kontena::Command
    include Kontena::Cli::Common

    option '--force', :flag, 'Force remove', default: false, attribute_name: :forced

    def execute
      confirm unless forced?
      require 'kontena/machine/vagrant'
      Kontena::Machine::Vagrant::MasterDestroyer.new.run!
    end
  end
end
