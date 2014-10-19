class RemoveMembershipLevelFromMember < ActiveRecord::Migration
  def change
    remove_column :members, :membership_level, :string
  end
end
