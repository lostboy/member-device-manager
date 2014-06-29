class AddUserToDevicesDevice < ActiveRecord::Migration
  def change
    add_column :devices_devices, :user_id, :integer
    add_index :devices_devices, :user_id
  end
end
