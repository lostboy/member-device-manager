class MacAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is not a mac address") unless
      value =~ /^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$/i
  end
end
