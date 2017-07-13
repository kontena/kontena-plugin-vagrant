module Kontena::Plugin::Vagrant::Master
  class StopCommand < Kontena::Command
    include Kontena::Cli::Common

    def execute
      require_relative '../../../machine/vagrant'

      vagrant_path = "#{Dir.home}/.kontena/vagrant_master"
      abort("Cannot find Vagrant kontena-master".colorize(:red)) unless Dir.exist?(vagrant_path)
      Dir.chdir(vagrant_path) do
        spinner "Triggering 'vagrant halt' for kontena-master"
        exit $?.exitstatus unless system('vagrant halt')
      end
    end
  end
end
