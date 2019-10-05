# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "base"
  config.vm.guest = :windows
  config.vm.communicator = :winrm
  config.winrm.transport = :negotiate
  config.winrm.ssl_peer_verification = false
  config.winrm.basic_auth_only = false
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  config.winrm.timeout = 300
  config.winrm.retry_limit = 10
  config.winrm.retry_delay = 30  # seconds
  config.vm.box = "jptoto/winsrv2019"
  config.vm.hostname = "globo-dc01"
  config.vm.network "private_network", ip: "10.0.2.10"
  
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
  
    # Customize the amount of memory on the VM:
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--vram", "256"]
    vb.customize ["setextradata", :id, "--CustomVideoMode1", "1024x768x32"]
  end

  $script = <<-SCRIPT
  Install-WindowsFeature AD-Domain-Services
  SCRIPT

  $configDomainScript = <<-SCRIPT
  Install-ADDSForest `
  -SkipPreChecks:$true `
  -SafeModeAdministratorPassword (ConvertTo-SecureString -String "P@ssw0rd1!" -AsPlainText -Force) `
  -CreateDnsDelegation:$false `
  -DatabasePath "C:/Windows/NTDS" `
  -DomainMode "Win2012R2" `
  -DomainName "globomantics.local" `
  -DomainNetbiosName "globomantics" `
  -ForestMode "Win2012R2" `
  -InstallDns:$true `
  -LogPath "C:/Windows/NTDS" `
  -NoRebootOnCompletion:$false `
  -SysvolPath "C:/Windows/SYSVOL" `
  -Force:$true
  SCRIPT

  config.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", path: "scripts/install_ad_tools.ps1"
  #config.vm.provision :reload
  config.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", inline: "Import-Module ADDSDeployment"
  config.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", inline: $configDomainScript
end
