Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "site-cookbooks/main/Berksfile"
  config.vm.provision "chef_zero" do |chef|
    chef.cookbooks_path = [ 'cookbooks', 'site-cookbooks' ]
    chef.data_bags_path = "data_bags"
    chef.nodes_path = "nodes"
    chef.roles_path = "roles"
    chef.add_recipe "main::default"
  end
  host = RbConfig::CONFIG['host_os']
  config.vm.provider :virtualbox do |vb|
    vb.name = "snappydata-ubuntu-kitchen"
    vb.gui = false
    # https://github.com/actuallymentor/vagrant-smus/blob/master/Vagrantfile
    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      vb.cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      vb.memory = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      vb.cpus = `nproc`.to_i
      vb.memory = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    elsif host =~ /mingw*/
      vb.cpus = `wmic cpu get NumberOfCores`.split("\n")[2].to_i
      vb.memory = `wmic OS get TotalVisibleMemorySize`.split("\n")[2].to_i / 1024 /4
    end
  end
  config.vm.network "private_network", ip: "192.168.55.4", auto_config: false
end
