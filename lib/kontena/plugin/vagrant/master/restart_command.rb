module Kontena::Plugin::Vagrant::Master
  class RestartCommand < Kontena::Command
    include Kontena::Cli::Common

    def execute
      require_relative '../../../machine/vagrant'

      vagrant_path = "#{Dir.home}/.kontena/vagrant_master"
      abort("Cannot find Vagrant kontena-master".colorize(:red)) unless Dir.exist?(vagrant_path)
      Dir.chdir(vagrant_path) do
        spinner "Executing 'vagrant reload' for kontena-master"
        exit $?.exitstatus unless system('vagrant reload')
        spinner "Vagrant machine restarted"
      end
    end
  end
end
