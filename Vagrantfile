Vagrant.configure("2") do |config|

  config.vm.box = "maquinet"

  config.berkshelf.enabled = true
  #config.ssh.username = "ubuntu"

  vagrant_user = "vagrant"
  
  config.vm.provider :vmware_fusion do |v, override|
    override.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"
  end

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV["AWS_ACCESS_KEY"]
    aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
    aws.keypair_name = "maquinet-server"

    aws.ami = "ami-70f96e40"
    aws.instance_type = "t1.micro"

    aws.region = "us-west-2"
    aws.security_groups = [ "quick-start-1" ]

    override.ssh.username = "ubuntu"
    vagrant_user = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/keys/maquinet-server.pem"

  end

  provision_script= <<SCRIPT
  if [[ $(which chef-solo) != '/usr/local/bin/chef-solo' ]]; then
    curl -L https://www.opscode.com/chef/install.sh | sudo bash
    echo 'export PATH="/opt/chef/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile
  fi
SCRIPT
  config.vm.provision :shell, :inline => provision_script

  config.vm.provision :chef_solo do |chef|
    chef.roles_path = ["roles"]
    chef.add_role "maquinet-server" 
    chef.json = {
      rvm: {
        default_ruby: "ruby-1.9.3-p327",
        vagrant: {
          user: vagrant_user,
          system_chef_solo: "/usr/bin/chef-solo"
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
