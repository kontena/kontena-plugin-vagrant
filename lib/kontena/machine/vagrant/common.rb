require 'fileutils'
require 'erb'
require 'open3'
require 'json'

module Kontena
  module Machine
    module Vagrant
      module Common

        def erb(template, vars)
          ERB.new(template).result(OpenStruct.new(vars).instance_eval { binding })
        end

        def run_command(cmd)
          system(cmd)
          exit_code = $?
          exit exit_code if exit_code != 0
        end
      end
    end
  end
end