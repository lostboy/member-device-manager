class Devices::Device < ActiveRecord::Base
  has_paper_trail

  ROUTER_FIELDS = [
    :kind,
    :mac_address,
    :enabled
  ]

  belongs_to :member
  belongs_to :type, class_name: 'Devices::Type'

  validates :member, presence: true
  validates :type, presence: true
  validates :mac_address, presence: true, mac_address: true

  after_save :update_router, if: :router_fields_changed?

  def enable!
    self.enabled = true
    save!
  end

  def disable!
    self.enabled = false
    save!
  end

  # Update router with new device information
  #
  # If we have detected that the enabled field has changed, and only that
  # just enable or disable the device in the router.
  def update_router
    router = Router.new
    if @enabled_changed and not self.enabled
      router.disable self
    elsif @enabled_changed and self.enabled
      router.enable self
    else
      router.update self
    end
  end

  # If only "enabled" has changed, set instance variable @enabled_changed
  # to do a special router update in that case.
  def router_fields_changed?
    changed_fields = self.changed.map { |field| field.to_sym }

    # Remove updated_at and created_at
    changed_fields.delete :updated_at
    changed_fields.delete :created_at

    if enabled_changed? and changed_fields.length == 1
      @enabled_changed = true
    else
      @enabled_changed = false
    end

    ROUTER_FIELDS.map do |router_field|
      changed_fields.include? router_field
    end.any?
  end
end
