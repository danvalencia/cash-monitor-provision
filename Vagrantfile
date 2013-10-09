Vagrant.configure("2") do |config|

  system_chef_solo = "/opt/chef/bin/chef-solo"

  config.vm.box = "maquinet"

  config.berkshelf.enabled = true
  
  config.omnibus.chef_version = "11.6.0"

  config.vm.synced_folder "~/workspace/maquinet/cash-monitor", "/home/vagrant/cash-monitor"
  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.network :forwarded_port, guest: 80, host: 8001

  config.vm.provider :vmware_fusion do |vmware, override|
    override.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"
    $vagrant_user = "vagrant"
  end

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV["AWS_ACCESS_KEY"]
    aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
    aws.keypair_name = "maquinet-server"

    aws.ami = "ami-70f96e40"
    aws.instance_type = "t1.micro"

    aws.region = "us-west-2"
    aws.security_groups = [ "quick-start-1" ]

    $vagrant_user = "ubuntu"
    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/keys/maquinet-server.pem"
  end

  config.vm.provision :chef_solo do |chef|
    chef.roles_path = ["roles"]
    chef.add_role "maquinet-server" 
    chef.json = {
      rvm: {
        default_ruby: "ruby-1.9.3-p327",
        vagrant: {
          user: $vagrant_user, 
          system_chef_solo: system_chef_solo
        }
      },
      mysql: {
        server_root_password: "m4qu1n3t",
        server_repl_password: "m4qu1n3t",
        server_debian_password: "m4qu1n3t"
      }
    }
  end

end
