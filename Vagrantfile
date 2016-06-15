# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "aws"
  config.vm.hostname = "aws"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider :aws do |aws, override|
     aws.access_key_id = ""
     aws.secret_access_key = ""
     # Ensure you have the right region and avalability zone
     aws.region = "ap-southeast-1"
     aws.availability_zone = "ap-southeast-1b"

     # AMI from which we'll launch EC2 Instance
     aws.ami =  "ami-c4ae7ea7" # ap-southeast-1 Ubuntu 14.04 hvm:ebs-ssd
     # Make sure the key pair was created for the given region
     aws.keypair_name = "ubuntu"
     aws.instance_type = "t2.micro"
     aws.block_device_mapping = [{ 'DeviceName' => '/dev/sda1', 'Ebs.VolumeSize' => 10 }]
     aws.security_groups = ["ubuntu"]
     aws.tags = {
      'Name' => 'Vagrant EC2 Instance',
      'Environment' => 'vagrant-sandbox'
      }  
    # Credentials to login to EC2 Instance
    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/ubuntu.pem"
  end
  
  # Configuration for Ansible as Provisioner
  config.vm.provision :ansible do |ansible|
     ansible.playbook = "deploy.yml"
     ansible.verbose = "vvv"
     ansible.host_key_checking = false
     ansible.limit = 'all'
     ansible.sudo = true
  end
end
