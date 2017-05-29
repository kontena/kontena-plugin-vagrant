class Kontena::Plugin::VagrantCommand < Kontena::Command
  subcommand 'master', 'Vagrant master related commands', load_subcommand('kontena/plugin/vagrant/master_command')
  subcommand 'node', 'Vagrant node related commands', load_subcommand('kontena/plugin/vagrant/node_command')
end
