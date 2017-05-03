require 'securerandom'

module Kontena::Plugin::Vagrant::Master
  class CreateCommand < Kontena::Command
    include Kontena::Cli::Common

    option "--name", "NAME", "Set master name"
    option "--memory", "MEMORY", "How much memory node has"
    option "--version", "VERSION", "Define installed Kontena version", default: 'latest'
    option "--vault-secret", "VAULT_SECRET", "Secret key for Vault"
    option "--vault-iv", "VAULT_IV", "Initialization vector for Vault"
    option "--coreos-channel", "CHANNEL", "CoreOS release channel", default: 'stable'

    def execute
      require_relative '../../../machine/vagrant'
      mem = ask_instance_memory
      provisioner.run!(
        name: name,
        memory: mem,
        version: version,
        vault_secret: vault_secret || SecureRandom.hex(24),
        vault_iv: vault_iv || SecureRandom.hex(24),
        initial_admin_code: SecureRandom.hex(16),
        coreos_channel: coreos_channel
      )
    end

    def ask_instance_memory
      if self.memory.nil?
        prompt.select("Choose a size") do |menu|
          %w(512 1024 2048).each do |mem|
            menu.choice "#{mem}MB", mem
          end
        end
      else
        self.memory
      end
    end

    def provisioner
      Kontena::Machine::Vagrant::MasterProvisioner.new
    end
  end
end
