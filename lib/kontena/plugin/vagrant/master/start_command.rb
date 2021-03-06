module Kontena::Plugin::Vagrant::Master
  class StartCommand < Kontena::Command
    include Kontena::Cli::Common

    def execute
      require_relative '../../../machine/vagrant'

      vagrant_path = "#{Dir.home}/.kontena/vagrant_master"
      abort("Cannot find Vagrant node kontena-master".colorize(:red)) unless Dir.exist?(vagrant_path)
      Dir.chdir(vagrant_path) do
        spinner "Triggering 'vagrant up' for kontena-master"
        exit $?.exitstatus unless system('vagrant up')
      end
    end
  end
end
