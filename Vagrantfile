# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  # config.vm.box = "bento/centos-7.4"
  # config.vm.box_version = "201802.02.0"

  server_configs = [
    {"hostname" => "ci", "ip" => "192.168.33.25", "memory_size" => "1024", "execute_script" => true},
    {"hostname" => "apps", "ip" => "192.168.33.26", "memory_size" => "1024", "execute_script" => false, "sync_apps_dir" => true},
    {"hostname" => "db", "ip" => "192.168.33.27", "memory_size" => "1024", "execute_script" => false, "execute_sql" => true},
  ]

  server_configs.each do |server_config|
    config.vm.define "#{server_config['hostname']}" do |server|
      server.vm.hostname = server_config['hostname']
      server.vm.box = "bento/centos-7.4"
      server.vm.box_version = "201803.24.0"
      server.vm.network :private_network, ip: server_config['ip']
      # server.vm.network :forwarded_port, guest: 22, host: server_config['port'], id: "ssh"
      server.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", server_config['memory_size']]
        # v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        # v.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 0]
      end
   
      server.vm.synced_folder '.', '/vagrant', disabled: true
      if server_config['sync_apps_dir'] then
        server.vm.synced_folder './app', '/home/vagrant/app', owner: "vagrant", group: "vagrant", create: true, mount_options: ["dmode=777,fmode=777"]
        server.vm.synced_folder './app', '/home/vagrant/app1', owner: "vagrant", group: "vagrant", create: true, mount_options: ["dmode=777,fmode=777"]
        server.vm.synced_folder './app', '/home/vagrant/app2', owner: "vagrant", group: "vagrant", create: true, mount_options: ["dmode=777,fmode=777"]
        server.vm.provision :shell, path: "Vagrant/change-permissions-for-nginx.sh"
      end
      
      if server_config['execute_script'] then
        server.vm.synced_folder '.', '/home/vagrant/ansible-playbook', owner: "vagrant", group: "vagrant", create: true
        server.vm.synced_folder './app', '/home/vagrant/ansible-playbook/app', disabled: true
        server.vm.provision :shell, path: "Vagrant/bootstrap.sh"
      end

      if server_config['execute_sql'] then
        server.vm.synced_folder './SQL_scripts', '/home/vagrant/SQL_scripts', owner: "vagrant", group: "vagrant", create: true
      end
      
      server.ssh.private_key_path = "ssh/insecure_private_key"
      server.ssh.insert_key = false
    end
  end
end