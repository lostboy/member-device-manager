class AddIpAddressToDevicesDevice < ActiveRecord::Migration
  def change
    add_column :devices_devices, :ip_address, :inet
  end
end
