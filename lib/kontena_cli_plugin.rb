require 'kontena_cli'
require_relative 'kontena/plugin/vagrant'
require_relative 'kontena/plugin/vagrant_command'

Kontena::MainCommand.register("vagrant", "Vagrant specific commands", Kontena::Plugin::VagrantCommand)
