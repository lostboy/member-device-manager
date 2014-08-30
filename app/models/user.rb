
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
end
