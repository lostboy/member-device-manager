class AddMembershipLevelToMember < ActiveRecord::Migration
  def change
    add_column :members, :membership_level_id, :integer
    add_index :members, :membership_level_id
  end
end
