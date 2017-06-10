require_relative 'common'

module Kontena
  module Machine
    module Vagrant
      class NodeDestroyer
        include RandomName
        include Kontena::Machine::Vagrant::Common
        include Kontena::Cli::ShellSpinner

        attr_reader :client, :api_client

        # @param [Kontena::Client] api_client Kontena api client
        def initialize(api_client)
          @api_client = api_client
        end

        def run!(grid, name)
          vagrant_path = "#{Dir.home}/.kontena/#{grid}/#{name}"
          Dir.chdir(vagrant_path) do
            spinner "Triggering termination of Vagrant machine #{name.colorize(:cyan)}"
            run_command('vagrant destroy -f')
            FileUtils.remove_entry_secure(vagrant_path)
          end
          node = api_client.get("grids/#{grid}/nodes")['nodes'].find{|n| n['name'] == name}
          if node
            spinner "Removing node #{name.colorize(:cyan)} from grid #{grid.colorize(:cyan)} " do
              api_client.delete("nodes/#{grid}/#{name}")
            end
          end
        end
      end
    end
  end
end
