require 'fileutils'

module Kontena
  module Machine
    module Vagrant
      class MasterDestroyer

        include Kontena::Cli::ShellSpinner

        attr_reader :client, :api_client

        # @param [Kontena::Client] api_client Kontena api client
        def initialize(api_client)
          @api_client = api_client
        end

        def run!
          vagrant_path = "#{Dir.home}/.kontena/vagrant_master"
          Dir.chdir(vagrant_path) do
            spinner "Terminating Kontena Master from Vagrant " do
              Open3.popen2('vagrant destroy -f') do |stdin, output, wait|
                while o = output.gets
                  puts o if ENV['DEBUG']
                end
                if wait.value == 0
                  FileUtils.remove_entry_secure(vagrant_path)
                end
              end
            end
          end
        end
      end
    end
  end
end
