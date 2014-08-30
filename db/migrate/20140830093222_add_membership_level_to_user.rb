class AddMembershipLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :membership_level, :string
  end
end
