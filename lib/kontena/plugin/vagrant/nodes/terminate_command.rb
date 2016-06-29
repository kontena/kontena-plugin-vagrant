module Kontena::Plugin::Vagrant::Nodes
  class TerminateCommand < Kontena::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions

    parameter "NAME", "Node name"

    def execute
      require_api_url
      require_current_grid

      require_relative '../../../machine/vagrant'
      
      destroyer = destroyer(client(require_token))
      destroyer.run!(current_grid, name)
    end

    # @param [Kontena::Client] client
    def destroyer(client)
      Kontena::Machine::Vagrant::NodeDestroyer.new(client)
    end
  end
end
