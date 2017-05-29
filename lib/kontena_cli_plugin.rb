require 'kontena_cli'
require 'kontena/plugin/vagrant'
require 'kontena/cli/subcommand_loader'

Kontena::MainCommand.register("vagrant", "Vagrant specific commands", Kontena::Cli::SubcommandLoader.new('kontena/plugin/vagrant_command'))
