require_relative 'common'

module Kontena
  module Machine
    module Vagrant
      class MasterDestroyer
        include Kontena::Machine::Vagrant::Common
        include Kontena::Cli::ShellSpinner

        def run!
          vagrant_path = "#{Dir.home}/.kontena/vagrant_master"
          Dir.chdir(vagrant_path) do
            spinner "Triggering termination of Kontena Master from Vagrant"
            run_command('vagrant destroy -f')
            FileUtils.remove_entry_secure(vagrant_path)
          end
        end
      end
    end
  end
end
