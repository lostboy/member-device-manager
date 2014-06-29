class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is not an email") unless
      value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end

class User < ActiveRecord::Base
  has_many :devices, class_name: 'Devices::Device'

  validates :email, presence: true, uniqueness: true, email: true
  validates :first_name, presence: true
end
