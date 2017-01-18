module Kontena::Plugin::Vagrant::Master
  class SshCommand < Kontena::Command
    include Kontena::Cli::Common

    parameter "[COMMANDS] ...", "Run command on Master"

    def execute
      require 'shellwords'
      require_relative '../../../machine/vagrant'

      vagrant_path = "#{Dir.home}/.kontena/vagrant_master"
      abort("Cannot find Vagrant kontena-master".colorize(:red)) unless Dir.exist?(vagrant_path)

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
