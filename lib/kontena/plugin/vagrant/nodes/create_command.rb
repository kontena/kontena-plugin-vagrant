module Kontena::Plugin::Vagrant::Nodes
  class CreateCommand < Kontena::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions

    parameter "[NAME]", "Node name"
    option "--instances", "AMOUNT", "How many nodes will be created"
    option "--memory", "MEMORY", "How much memory node has"
    option "--version", "VERSION", "Define installed Kontena version", default: 'latest'
    option "--coreos-channel", "CHANNEL", "CoreOS release channel", default: 'stable'

    def execute
      api_url = require_api_url
      require_current_grid

      instance_count = ask_instances
      instance_memory = ask_instance_memory

      require_relative '../../../machine/vagrant'

      grid = fetch_grid
      provisioner = provisioner(client(require_token))
      instance_count.to_i.times do |i|
        provisioner.run!(
          master_uri: api_url,
          grid_token: grid['token'],
          grid: current_grid,
          name: name,
          instance_number: i + 1,
          memory: instance_memory,
          version: version,
          coreos_channel: coreos_channel
        )
      end
    end

    def ask_instances
      if self.instances.nil?
        prompt.ask("How many nodes?: ", default: 1, in: '1..10')
      else
        self.instances
      end
    end

    def ask_instance_memory
      if self.memory.nil?
        prompt.select("Choose a size ") do |menu|
          %w(1024 2048 4096).each do |mem|
            menu.choice "#{mem}MB", mem
          end
        end
      else
        self.memory
      end
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
