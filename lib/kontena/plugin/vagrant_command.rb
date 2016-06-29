require_relative 'vagrant/master_command'
require_relative 'vagrant/node_command'

class Kontena::Plugin::VagrantCommand < Kontena::Command

  subcommand 'master', 'Vagrant master related commands', Kontena::Plugin::Vagrant::MasterCommand
  subcommand 'node', 'Vagrant node related commands', Kontena::Plugin::Vagrant::NodeCommand

  def execute
  end
end
