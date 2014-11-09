class AddEnabledToDevicesDevice < ActiveRecord::Migration
  def change
    add_column :devices_devices, :enabled, :boolean, default: true
  end
end
