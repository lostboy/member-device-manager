class Devices::Device < ActiveRecord::Base
  belongs_to :type, class_name: 'Devices::Type'

  validates :type, presence: true
  validates :mac_address, presence: true
end
