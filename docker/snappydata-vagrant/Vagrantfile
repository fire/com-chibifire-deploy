Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  # Run Ansible from the Vagrant VM
  config.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.sudo = true
      ansible.install = true
      ansible.verbose = true
  end
  host = RbConfig::CONFIG['host_os']
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    # https://github.com/actuallymentor/vagrant-smus/blob/master/Vagrantfile
    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      vb.cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      vb.memory = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      vb.cpus = `nproc`.to_i / 2
      vb.memory = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    elsif host =~ /mingw*/
      vb.cpus = `wmic cpu get NumberOfCores`.split("\n")[2].to_i / 2
      vb.memory = `wmic OS get TotalVisibleMemorySize`.split("\n")[2].to_i / 1024 /4
    end
  end
  config.vm.network "private_network", ip: "192.168.55.4"
end
