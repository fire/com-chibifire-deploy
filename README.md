# How to install

This was tested on Windows 10

Install:

* ChefDK
* Vagrant
* vagrant plugin install vagrant-berkshelf
* vagrant plugin install vagrant-winnfsd
* \<abacaj> manually remove it from virtualbox under file -> Preferences -> Network -> Host-only Networks highlight the available network and click the minus sign to remove it.
* vagrant up

Point your sql client to `vagrant-ubuntu-trusty-64.192.168.55.4.xip.io`.
