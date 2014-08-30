class AddMembershipRenewalDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :membership_renewal_date, :datetime
  end
end
