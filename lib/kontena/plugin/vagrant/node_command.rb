require_relative 'nodes/create_command'
require_relative 'nodes/start_command'
require_relative 'nodes/stop_command'
require_relative 'nodes/restart_command'
require_relative 'nodes/ssh_command'
require_relative 'nodes/terminate_command'

class Kontena::Plugin::Vagrant::NodeCommand < Kontena::Command

  subcommand "create", "Create a new node to Vagrant", Kontena::Plugin::Vagrant::Nodes::CreateCommand
  subcommand "ssh", "Ssh into Vagrant node", Kontena::Plugin::Vagrant::Nodes::SshCommand
  subcommand "start", "Start Vagrant node", Kontena::Plugin::Vagrant::Nodes::StartCommand
  subcommand "stop", "Stop Vagrant node", Kontena::Plugin::Vagrant::Nodes::StopCommand
  subcommand "restart", "Restart Vagrant node", Kontena::Plugin::Vagrant::Nodes::RestartCommand
  subcommand "terminate", "Terminate Vagrant node", Kontena::Plugin::Vagrant::Nodes::TerminateCommand

  def execute
  end
end
