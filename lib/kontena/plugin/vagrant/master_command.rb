require_relative 'master/create_command'
require_relative 'master/start_command'
require_relative 'master/stop_command'
require_relative 'master/restart_command'
require_relative 'master/ssh_command'
require_relative 'master/terminate_command'

class Kontena::Plugin::Vagrant::MasterCommand < Kontena::Command

  subcommand "create", "Create a new Vagrant master", Kontena::Plugin::Vagrant::Master::CreateCommand
  subcommand "ssh", "SSH into Vagrant master", Kontena::Plugin::Vagrant::Master::SshCommand
  subcommand "start", "Start Vagrant master", Kontena::Plugin::Vagrant::Master::StartCommand
  subcommand "stop", "Stop Vagrant master", Kontena::Plugin::Vagrant::Master::StopCommand
  subcommand "restart", "Restart Vagrant master", Kontena::Plugin::Vagrant::Master::RestartCommand
  subcommand "terminate", "Terminate Vagrant master", Kontena::Plugin::Vagrant::Master::TerminateCommand

  def execute
  end
end
