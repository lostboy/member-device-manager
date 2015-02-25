Vagrant.configure("2") do |config|
  
  config.vm.define "develop021" do |v|
    v.vm.provider "docker" do |d|
      d.build_dir = "."
      #d.has_ssh = true
      d.remains_running = true
    end
    v.vm.synced_folder ".", "/app"
  end

  #config.vm.define "app" do |v|
  #  v.vm.provider "docker" do |d|
  #    d.build_dir = "."
  #    d.remains_running = false
  #  end
  #end

  #config.vm.define "db" do |v|
  #  v.vm.provider "docker" do |d|
  #    d.image = "paintedfox/postgresql"
  #  end
  #end

end