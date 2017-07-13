module Kontena::Plugin::Vagrant::Master
  class StopCommand < Kontena::Command
    include Kontena::Cli::Common

    def execute
      require_relative '../../../machine/vagrant'

      vagrant_path = "#{Dir.home}/.kontena/vagrant_master"
      abort("Cannot find Vagrant kontena-master".colorize(:red)) unless Dir.exist?(vagrant_path)
      Dir.chdir(vagrant_path) do
        spinner "Triggering 'vagrant halt' for kontena-master"
        system('vagrant halt')
        exit_code = $?
        exit exit_code if exit_code != 0
      end
    end
  end
end
