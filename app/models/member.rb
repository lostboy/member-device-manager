class Member < ActiveRecord::Base
  has_paper_trail

  ROUTER_FIELDS = [
    :first_name,
    :last_name,
    :email,
    :membership_status,
    :membership_level_id,
    :active
  ]

  # We only want to do this on update, if we do it on create we will do it
  # twice. One time when the member gets created, and then once more when the
  # devices themself gets created.
  after_update :update_router, if: :router_fields_changed?

  has_many :devices, class_name: 'Devices::Device'

  belongs_to :membership_level, class_name: 'Membership::Level'

  accepts_nested_attributes_for :devices, allow_destroy: true, reject_if: :all_blank

  validates :email, presence: true, uniqueness: true, email: true
  validates :first_name, presence: true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def to_s
    self.full_name
  end

  def as_csv(options={})
    {
      'First'             => first_name,
      'Last'              => last_name,
      'email'             => email,
      'membership level'  => membership_level,
      'renewal date'      => membership_renewal_date,
      'membership status' => membership_status
    }
  end

  def update_router
    # If we change the active state, we disable/enable the devices
    # for the user, we don't delete them.
    if @active_changed
      if not self.active
        method_name = :disable!
      else self.active
        method_name = :enable!
      end
    else
      method_name = :update_router
    end

    devices.each do |device|
      device.send method_name
    end
  end

  def router_fields_changed?
    changed_fields = self.changed.map { |field| field.to_sym }

    # Remove updated_at and created_at
    changed_fields.delete :updated_at
    changed_fields.delete :created_at

    if active_changed? and changed_fields.length == 1
      @active_changed = true
    else
      @active_changed = false
    end

    ROUTER_FIELDS.map do |router_field|
      changed_fields.include? router_field
    end.any?
  end
end
