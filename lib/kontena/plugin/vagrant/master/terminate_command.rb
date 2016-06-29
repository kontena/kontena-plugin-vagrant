module Kontena::Plugin::Vagrant::Master
  class TerminateCommand < Kontena::Command
    include Kontena::Cli::Common

    def execute
      require_api_url

      require 'kontena/machine/vagrant'
      destroyer = destroyer(client(require_token))
      destroyer.run!
    end

    def destroyer(client)
      Kontena::Machine::Vagrant::MasterDestroyer.new(client)
    end
  end
end
