module Kontena::Plugin::Vagrant::Master
  class SshCommand < Kontena::Command
    include Kontena::Cli::Common

    def execute
      require_relative '../../../machine/vagrant'

      vagrant_path = "#{Dir.home}/.kontena/vagrant_master"
      abort("Cannot find Vagrant kontena-master".colorize(:red)) unless Dir.exist?(vagrant_path)

      Dir.chdir(vagrant_path) do
        system('vagrant ssh')
      end
    end
  end
end
