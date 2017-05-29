class Kontena::Plugin::Vagrant::MasterCommand < Kontena::Command
  subcommand "create", "Create a new Vagrant master", load_subcommand('kontena/plugin/vagrant/master/create_command')
  subcommand "ssh", "SSH into Vagrant master", load_subcommand('kontena/plugin/vagrant/master/ssh_command')
  subcommand "start", "Start Vagrant master", load_subcommand('kontena/plugin/vagrant/master/start_command')
  subcommand "stop", "Stop Vagrant master", load_subcommand('kontena/plugin/vagrant/master/stop_command')
  subcommand "restart", "Restart Vagrant master", load_subcommand('kontena/plugin/vagrant/master/restart_command')
  subcommand "terminate", "Terminate Vagrant master", load_subcommand('kontena/plugin/vagrant/master/terminate_command')
end
