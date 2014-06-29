class RenameTypeToKindOnDevicesType < ActiveRecord::Migration
  def change
    rename_column :devices_types, :type, :kind
  end
end
