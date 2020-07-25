# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision "mirror",
    type: "shell",
    preserve_order: true do |s|
    s.inline = "pacman -Syyu --noconfirm"
  end

  config.vm.provision "ansible",
    type: "ansible",
    preserve_order: true do |ansible|
    ansible.playbook = "local_env.yml"
    ansible.vault_password_file = "./bin/password.sh"
    ansible.groups = {
      "desktop" => ["default"],
      "desktop:vars" => {
        "theme" => "github"
      }
    }
  end
end
