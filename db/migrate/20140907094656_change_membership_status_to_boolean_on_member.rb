class ChangeMembershipStatusToBooleanOnMember < ActiveRecord::Migration
  def change
    change_column :members, :membership_status, 'bool USING TRUE'
  end
end
