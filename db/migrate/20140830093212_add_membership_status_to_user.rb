class AddMembershipStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :membership_status, :string
  end
end
