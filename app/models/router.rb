require 'net/ssh'

class Router
  SCRIPTS = {
    add: 'manager.rt',
    remove: 'manager.rt',
    disable: 'devable.rt',
    enable: 'devable.rt'
  }

  ARGUMENTS_MAPPING = {
    enable: '-e',
    disable: '-d',
    show: '-s',
    first_name: '-f',
    last_name: '-l',
    email: '-e',
    device_type: '-t',
    mac_address: '-m',
    ip_address: '-i',
    hotspot: '-h'
  }

  def initialize
    @port     = Rails.application.secrets.router_port || 22
    @hostname = Rails.application.secrets.router_host
    @username = Rails.application.secrets.router_username
    @password = Rails.application.secrets.router_password
  end

  def register device
    device_info = {
      first_name: device.member.first_name,
      last_name: device.member.last_name,
      email: device.member.email,
      device_type: device.type.kind,
      mac_address: device.mac_address,
      ip_address: device.ip_address,
      hotspot: device.type.hotspot
    }
    # TODO: Make sure everything is not nil

    ssh(SCRIPTS[:add], hash_to_arguments(device_info))
  end

  def unregister device
    device_info = { mac_address: device.mac_address }
    ssh(SCRIPTS[:remove], hash_to_arguments(device_info))
  end

  def update device
    unregister device
    register device
  end

  def enable device
    device_info = { mac_address: device.mac_address, enable: true }
    ssh(SCRIPTS[:enable], hash_to_arguments(device_info))
  end

  def disable device
    device_info = { mac_address: device.mac_address, disable: true }
    ssh(SCRIPTS[:disable], hash_to_arguments(device_info))
  end

  def update_ip_address device
    device_info = [
      first_name: device.member.first_name,
      last_name: device.member.last_name,
      email: device.member.email,
      device_type: device.type.kind,
      mac_address: device.mac_address,
      ip_address: device.ip_address,
      hotspot: device.type.hotspot
    ]

    ssh(SCRIPTS[:dhcp], hash_to_arguments(device_info))
  end

  def ssh(script, arguments)
    unless Rails.env.to_sym == :test
      Net::SSH.start(@host, port: @port, username: @username, password: @password) do |ssh|
        output = ssh.exec!("#{script} #{arguments}")
      end
    end
  end

  # Convert a hash to the proper ssh script argument
  def hash_to_arguments hash
    # Remap the hash, with the correct ssh arguments
    arguments = Hash[hash.map { |k, v| [ARGUMENTS_MAPPING[k], v] }]

    # Remove blank values from hash
    arguments.delete_if { |key, value| value.blank? }

    # Downcase every value in the hash, except mac_address
    arguments = Hash[arguments.map { |k, v| [k, v.to_s.downcase] }]
    mac_address_key = ARGUMENTS_MAPPING[:mac_address]
    if arguments[mac_address_key]
      arguments[mac_address_key] = arguments[mac_address_key].upcase
    end

    # Convert the hash into a string by joining key and value
    arguments.map { |e| e.join(" ") }.join(" ")
  end
end
