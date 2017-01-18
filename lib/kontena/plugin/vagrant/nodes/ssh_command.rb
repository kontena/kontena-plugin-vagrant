module Kontena::Plugin::Vagrant::Nodes
  class SshCommand < Kontena::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions

    parameter "NAME", "Node name"
    parameter "[COMMANDS] ...", "Run command on node"

    def execute
      require_api_url
      require_current_grid

      require 'shellwords'
      require_relative '../../../machine/vagrant'

      vagrant_path = "#{Dir.home}/.kontena/#{current_grid}/#{name}"
      abort("Cannot find Vagrant node #{name}".colorize(:red)) unless Dir.exist?(vagrant_path)

      cmd = "vagrant ssh"
      if self.commands_list && !self.commands_list.empty?
        cmd << " -c '#{self.commands_list.shelljoin}'" 
      end
      Dir.chdir(vagrant_path) do
        system(cmd)
      end
    end
  end
end
