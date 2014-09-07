class AddNexudusIdToMember < ActiveRecord::Migration
  def change
    add_column :members, :nexudus_id, :integer
  end
end
