Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "site-cookbooks/main/Berksfile"
  config.vm.provision "chef_zero" do |chef|
    chef.cookbooks_path = [ 'cookbooks', 'site-cookbooks' ]
    chef.data_bags_path = "data_bags"
    chef.nodes_path = "nodes"
    chef.roles_path = "roles"
    chef.add_recipe "main::default"
  end
  config.vm.provider :virtualbox do |vb|
    vb.name = "snappydata-ubuntu-kitchen"
    vb.gui = false
    vb.memory = "16384"
  end
end
