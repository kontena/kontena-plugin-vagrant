module Kontena::Plugin::Vagrant::Master
  class TerminateCommand < Kontena::Command
    include Kontena::Cli::Common

    option '--force', :flag, 'Force remove', default: false, attribute_name: :forced

    def execute
      require_api_url

      confirm unless forced?

      require_relative '../../../machine/vagrant'
      destroyer = destroyer(client(require_token))
      destroyer.run!
    end

    def destroyer(client)
      Kontena::Machine::Vagrant::MasterDestroyer.new(client)
    end
  end
end
