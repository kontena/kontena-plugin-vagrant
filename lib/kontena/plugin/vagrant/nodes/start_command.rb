module Kontena::Plugin::Vagrant::Nodes
  class StartCommand < Kontena::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions
    include Kontena::Cli::ShellSpinner

    parameter "NAME", "Node name"

    def execute
      require_api_url
      require_current_grid

      require_relative '../../../machine/vagrant'
      
      vagrant_path = "#{Dir.home}/.kontena/#{current_grid}/#{name}"
      abort("Cannot find Vagrant node #{name}".colorize(:red)) unless Dir.exist?(vagrant_path)
      Dir.chdir(vagrant_path) do
        spinner "Starting Vagrant machine #{name.colorize(:cyan)} " do
          Open3.popen2('vagrant up') do |stdin, output, wait|
            while o = output.gets
              print o if ENV['DEBUG']
            end
          end
        end
      end
    end
  end
end
