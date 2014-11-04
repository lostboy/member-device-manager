class Devices::Device < ActiveRecord::Base
  has_paper_trail

  ROUTER_FIELDS = [
    :kind,
    :mac_address,
    :ip_address
  ]

  belongs_to :member
  belongs_to :type, class_name: 'Devices::Type'

  validates :member, presence: true
  validates :type, presence: true
  validates :mac_address, presence: true, mac_address: true

  before_create :renew, if: :manage_ip?

  after_save :update_router, if: :router_fields_changed?

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
    network = try(:member).try(:membership_level).try(:network)
    # TODO: Do not hardcode default network
    network ||= '10.10.1.0/24'
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

  def update_router(disable: nil, enable: nil)
    router = Router.new
    if disable
      router.disable self
    elsif enable
      router.enable self
    else
      router.update self
    end
  end

  def router_fields_changed?
    changed_fields = self.changed.map { |field| field.to_sym }
    ROUTER_FIELDS.map do |router_field|
      changed_fields.include? router_field
    end.any?
  end
end
