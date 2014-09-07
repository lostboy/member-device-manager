class CreateMembershipLevels < ActiveRecord::Migration
  def change
    create_table :membership_levels do |t|
      t.string :name
      t.string :price
      t.datetime :nexudus_updated_at
      t.datetime :nexudus_created_at
      t.integer :nexudus_id

      t.timestamps
    end
  end
end
