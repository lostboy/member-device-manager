require 'ipaddress'

class Network
  def initialize(network)
    @network = IPAddress.parse network
  end

  # Determine the first ip address in this network
  def first
    @network.first
  end

  # Determine the last ip address in this network
  def last
    @network.last
  end

  # Determine the taken ip addresses in this network.
  #
  # This is achieved by searching through the database for devices
  # with ip addresses in this network.
  def taken
    Devices::Device
      .where("ip_address <<= inet '#{@network.to_string}'")
      .pluck(:ip_address)
      .map(&:to_string)
  end

  # Determine the available ip addresses in this network
  #
  # This is achieved by going through all ip addresses in this network
  # and checking if anyone of them is taken.
  def available
    # Get a list of already taken ip addresses
    ip_addresses = taken

    # Remove the first and last value in the range (0 and 255)
    network = @network.to_a[1..-2]

    # Remove taken ip addresses from the array
    network.reject do |ip|
      ip_addresses.include? ip.to_s
    end
  end

  # Determine the next ip address to allocate in this network
  def next
    available.first.to_s
  end

  def to_s
    @network.to_string
  end
end
