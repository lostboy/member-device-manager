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
end
