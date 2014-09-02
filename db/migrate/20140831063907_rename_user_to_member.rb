class RenameUserToMember < ActiveRecord::Migration
  def change
    rename_table :users, :members
    rename_column :devices_devices, :user_id, :member_id
  end
end
