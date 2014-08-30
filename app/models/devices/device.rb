class Devices::Device < ActiveRecord::Base
  belongs_to :user
  belongs_to :type, class_name: 'Devices::Type'

  validates :user, presence: true
  validates :type, presence: true
  validates :mac_address, presence: true, mac_address: true
end
