require 'net/ssh'

class Router
  SCRIPTS = {
    add: 'rt.add.device',
    remove: 'rt.remove.device',
    disable: 'rt.disable.device',
    enable: 'rt.enable.device',
    dhcp: 'rt.mgr.dhcp'
  }

  def initialize
    @hostname = Rails.application.secrets.router_host
    @username = Rails.application.secrets.router_username
    @password = Rails.application.secrets.router_password
  end

  def register device
    device_info = [
      device.member.first_name,
      device.member.last_name,
      device.member.email,
      device.type.kind,
      device.mac_address,
      device.ip_address,
      device.type.hotspot
    ]

    # TODO: Make sure everything is not nil

    argument = device_info.join(",")

    ssh(SCRIPTS[:add], argument)
  end

  def unregister device
    argument = device.mac_address
    ssh(SCRIPTS[:remove], argument)
  end

  def update device
    unregister device
    register device
  end

  def enable device
    argument = device.mac_address
    ssh(SCRIPTS[:enable], argument)
  end

  def disable device
    argument = device.mac_address
    ssh(SCRIPTS[:disable], argument)
  end

  def update_ip_address device
    device_info = [
      device.member.first_name,
      device.member.last_name,
      device.member.email,
      device.type.kind,
      device.mac_address,
      device.ip_address,
      device.type.hotspot
    ]

    argument = device_info.join(",")

    ssh(SCRIPTS[:dhcp], argument)
  end

  def ssh(script, argument)
    Net::SSH.start(@host, @username, password: @password) do |ssh|
      output = ssh.exec!("#{script} #{argument}")
    end
  end
end
