# TODO: Watch for updates on the following fields:
# * first_name
# * last_name
# * email
# * membership_status
# * membership_level
# * devices -> device_type
# * devices -> mac_address
# * devices -> ip_address
#
# When they update, trigger router update (delete/add)

class User < ActiveRecord::Base
  has_many :devices, class_name: 'Devices::Device'

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
      'membership level'  => nil,
      'renewal date'      => nil,
      'membership status' => nil
    }
  end
end
