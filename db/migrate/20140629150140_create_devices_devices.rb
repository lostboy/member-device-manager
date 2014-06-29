class CreateDevicesDevices < ActiveRecord::Migration
  def change
    create_table :devices_devices do |t|
      t.macaddr :mac_address
      t.references :type, index: true

      t.timestamps
    end
    add_index :devices_devices, :mac_address
  end
end
