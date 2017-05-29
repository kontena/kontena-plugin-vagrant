class Kontena::Plugin::Vagrant::NodeCommand < Kontena::Command
  subcommand "create", "Create a new node to Vagrant", load_subcommand('kontena/plugin/vagrant/nodes/create_command')
  subcommand "ssh", "Ssh into Vagrant node", load_subcommand('kontena/plugin/vagrant/nodes/ssh_command')
  subcommand "start", "Start Vagrant node", load_subcommand('kontena/plugin/vagrant/nodes/start_command')
  subcommand "stop", "Stop Vagrant node", load_subcommand('kontena/plugin/vagrant/nodes/stop_command')
  subcommand "restart", "Restart Vagrant node", load_subcommand('kontena/plugin/vagrant/nodes/restart_command')
  subcommand "terminate", "Terminate Vagrant node", load_subcommand('kontena/plugin/vagrant/nodes/terminate_command')
end
