module Kontena::Plugin::Vagrant::Nodes
  class CreateCommand < Kontena::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions

    parameter "[NAME]", "Node name"
    option "--memory", "MEMORY", "How much memory node has", default: '1024'
    option "--version", "VERSION", "Define installed Kontena version", default: 'latest'

    def execute
      require_api_url
      require_current_grid

      require_relative '../../../machine/vagrant'

      grid = fetch_grid
      provisioner = provisioner(client(require_token))
      provisioner.run!(
        master_uri: api_url,
        grid_token: grid['token'],
        grid: current_grid,
        name: name,
        memory: memory,
        version: version
      )
    end

    # @param [Kontena::Client] client
    def provisioner(client)
      Kontena::Machine::Vagrant::NodeProvisioner.new(client)
    end

    # @return [Hash]
    def fetch_grid
      client(require_token).get("grids/#{current_grid}")
    end
  end
end
