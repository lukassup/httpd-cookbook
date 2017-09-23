Vagrant.configure(2) do |config|
  # required for InSpec port checks
  config.vm.provision 'shell', inline: <<-SHELL
    yum install -y net-tools || :
  SHELL
end
