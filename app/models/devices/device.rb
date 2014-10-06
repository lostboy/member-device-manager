class Devices::Device < ActiveRecord::Base
  belongs_to :member
  belongs_to :type, class_name: 'Devices::Type'

  validates :member, presence: true
  validates :type, presence: true
  validates :mac_address, presence: true, mac_address: true

  # Determine if we should manage the IP address of this device based
  # on which hotspot it belongs to.
  def manage_ip?
    case type.hotspot
    when 'hsv1-mem' then true
    when 'hsv2-bam' then false
    else false
    end
  end

  # Determine which network this device should belong to based on the
  # members membership level.
  def membership_network
    try(:member).try(:membership_level).try(:network)
  end

  # Renew a devices IP address.
  def renew
    network = Network.new membership_network
    self.ip_address = network.next
  end

  def renew!
    renew
    save!
  end

  # Release a device's IP address.
  def release
    self.ip_address = nil
  end

  def release!
    release
    save!
  end
end
