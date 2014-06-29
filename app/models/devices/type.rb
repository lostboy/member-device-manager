class Devices::Type < ActiveRecord::Base
  validates :name, presence: true
  validates :type, presence: true
end
