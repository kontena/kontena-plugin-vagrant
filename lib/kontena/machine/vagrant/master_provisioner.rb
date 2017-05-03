require 'fileutils'
require 'erb'
require 'open3'
require 'json'

module Kontena
  module Machine
    module Vagrant
      class MasterProvisioner
        include RandomName
        include Kontena::Machine::Common
        include Kontena::Cli::Common
        include Kontena::Cli::ShellSpinner

        API_URL = 'http://192.168.66.100:8080'
        attr_reader :client

        def initialize
          @client = Excon.new(API_URL)
        end

        def run!(opts)
          name = opts[:name] || generate_name
          version = opts[:version]
          memory = opts[:memory] || 1024
          vault_secret = opts[:vault_secret]
          vault_iv = opts[:vault_iv]
          initial_admin_code = opts[:initial_admin_code]
          coreos_channel = opts[:coreos_channel]
          vagrant_path = "#{Dir.home}/.kontena/vagrant_master/"
          if Dir.exist?(vagrant_path)
            puts "Oops... cannot create Kontena Master because installation path already exists."
            puts "If you are sure that no Kontena Masters exist on this machine, remove folder: #{vagrant_path}"
            abort
          end
          FileUtils.mkdir_p(vagrant_path)

          template = File.join(__dir__ , '/Vagrantfile.master.rb.erb')
          cloudinit_template = File.join(__dir__ , '/cloudinit.yml')
          vars = {
            name: name,
            server_name: name.sub('kontena-master-', ''),
            version: version,
            memory: memory,
            vault_secret: vault_secret,
            initial_admin_code: initial_admin_code,
            vault_iv: vault_iv,
            coreos_channel: coreos_channel,
            cloudinit: "#{vagrant_path}/cloudinit.yml"
          }
          vagrant_data = erb(File.read(template), vars)
          cloudinit = erb(File.read(cloudinit_template), vars)
          File.write("#{vagrant_path}/Vagrantfile", vagrant_data)
          File.write("#{vagrant_path}/cloudinit.yml", cloudinit)
          Dir.chdir(vagrant_path) do
            spinner "Creating Vagrant machine #{name.colorize(:cyan)} " do
              Open3.popen2("vagrant up") do |stdin, output, wait|
                while o = output.gets
                  print o if ENV['DEBUG']
                end
              end
            end
          end

          spinner "Waiting for #{name.colorize(:cyan)} to start " do
            sleep 1 until master_running?
          end

          master_version = nil
          spinner "Retrieving Kontena Master version" do
            master_version = JSON.parse(client.get(path: '/'))["version"] rescue nil
          end

          spinner "Kontena Master #{master_version} is now running at #{API_URL}"

          {
            name: name.sub('kontena-master-', ''),
            public_ip: API_URL.split('//').last,
            provider: 'vagrant',
            version: master_version,
            code: opts[:initial_admin_code]
          }
        end

        def erb(template, vars)
          ERB.new(template).result(OpenStruct.new(vars).instance_eval { binding })
        end

        def master_running?
          client.get(path: '/').status == 200
        rescue
          false
        end

        def generate_name
          "kontena-master-#{super}-#{rand(1..99)}"
        end
      end
    end
  end
end
