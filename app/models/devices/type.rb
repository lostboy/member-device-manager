class Devices::Type < ActiveRecord::Base
  has_paper_trail

  has_many :devices, class_name: 'Devices::Device'

  validates :name, presence: true
  validates :kind, presence: true
end
