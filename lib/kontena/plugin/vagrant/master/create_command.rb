require 'securerandom'

module Kontena::Plugin::Vagrant::Master
  class CreateCommand < Kontena::Command

    command_type :provision_master

    option "--memory", "MEMORY", "How much memory node has", default: '512'
    option "--version", "VERSION", "Define installed Kontena version", default: 'latest'
    option "--vault-secret", "VAULT_SECRET", "Secret key for Vault"
    option "--vault-iv", "VAULT_IV", "Initialization vector for Vault"

    def execute
      require_relative '../../../machine/vagrant'
      provisioner.run!(
        memory: memory,
        version: version,
        vault_secret: vault_secret || SecureRandom.hex(24),
        vault_iv: vault_iv || SecureRandom.hex(24),
        initial_admin_code: SecureRandom.hex(16)
      )
    end

    def provisioner
      Kontena::Machine::Vagrant::MasterProvisioner.new
    end
  end
end
