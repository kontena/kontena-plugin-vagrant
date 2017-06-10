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
          exit_code = 0
          Open3.popen3(cmd) do |stdin, stdout, stderr, wait|
            outputs = []
            outputs << Thread.new {
              while o = stdout.gets
                $stdout << o
              end
            }
            outputs << Thread.new {
              while o = stderr.gets
                $stderr << o
              end
            }
            exit_code = wait.value.exitstatus
            outputs.each(&:kill)
          end
          exit exit_code if exit_code != 0
        end
      end
    end
  end
end