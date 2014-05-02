# -*- mode: ruby -*-
# vi: set ft=ruby :

require "vagrant"

if Vagrant::VERSION < "1.2.1"
  raise "The Omnibus Build Lab is only compatible with Vagrant 1.2.1+"
end

host_project_path = File.expand_path("..", __FILE__)
guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"
project_name = "collectd"

Vagrant.configure("2") do |config|

  config.vm.hostname = "#{project_name}-omnibus-build-lab"

  config.vm.define 'ubuntu-12.04' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    #c.vm.box = "canonical-ubuntu-12.04"
    #c.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
    c.vm.box = "opscode-ubuntu-12.04"
    c.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"

  end

  config.vm.define 'centos-6' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-centos-6.4"
    c.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_centos-6.4_provisionerless.box"
  end

  config.vm.provider :virtualbox do |vb|
    # Give enough horsepower to build without taking all day.
    vb.customize [
      "modifyvm", :id,
      "--memory", "4096",
      "--cpus", "2"
    ]
  end

  # Ensure a recent version of the Chef Omnibus packages are installed
  config.omnibus.chef_version = :latest

  # Enable the berkshelf-vagrant plugin
  config.berkshelf.enabled = true
  # The path to the Berksfile to use with Vagrant Berkshelf
  config.berkshelf.berksfile_path = "./Berksfile"

  config.ssh.forward_agent = true

  host_project_path = File.expand_path("..", __FILE__)
  guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"

  config.vm.synced_folder host_project_path, guest_project_path

  # prepare VM to be an Omnibus builder
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      "omnibus" => {
        "build_user" => "vagrant",
        "build_dir" => guest_project_path,
        "install_dir" => "/opt/#{project_name}"
      }
    }

    chef.run_list = [
      "recipe[omnibus::default]"
    ]
  end

  config.vm.provision :shell, :inline => <<-CHEF_APPLY
    chef-apply -e 'package "unzip"'
  CHEF_APPLY

  config.vm.provision :shell, :inline => <<-OMNIBUS_BUILD
    export PATH=/usr/local/bin:$PATH
    cd #{guest_project_path}
    su vagrant -c "bundle install --binstubs"
    su vagrant -c "bin/omnibus build project #{project_name}"
  OMNIBUS_BUILD
end
