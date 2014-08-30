
class User < ActiveRecord::Base
  has_many :devices, class_name: 'Devices::Device'

  validates :email, presence: true, uniqueness: true, email: true
  validates :first_name, presence: true
end
