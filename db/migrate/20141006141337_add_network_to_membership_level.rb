class AddNetworkToMembershipLevel < ActiveRecord::Migration
  def change
    add_column :membership_levels, :network, :string
  end
end
