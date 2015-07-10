class RemoveIpAddress < ActiveRecord::Migration
  def change
  	remove_column :devices_devices, :ip_address, :inet
  end
end
