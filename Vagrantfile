Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  #config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

#  config.omnibus.chef_version = :latest
#  config.vm.provision :chef_client do |chef|
#    chef.provisioning_path = "/etc/chef"
#    chef.chef_server_url = "https://example.com"
#    chef.validation_key_path = "~/chef-repo/.chef/chibifire-chef-validator.pem"
#    chef.validation_client_name = "chibifire-chef-validator"
#    chef.node_name = "server"
# end
  config.vm.provision "chef_zero" do |chef|
    # Specify the local paths where Chef data is stored
    chef.cookbooks_path = "cookbooks"
    chef.data_bags_path = "data_bags"
    chef.nodes_path = "nodes"
    chef.roles_path = "roles"

    # Add a recipe
    # chef.add_recipe "apache"

    # Or maybe a role
    # chef.add_role "web"
  end
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
  end
end
