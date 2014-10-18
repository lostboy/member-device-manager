class AddHotSpotToDevicesType < ActiveRecord::Migration
  def change
    add_column :devices_types, :hotspot, :string
  end
end
