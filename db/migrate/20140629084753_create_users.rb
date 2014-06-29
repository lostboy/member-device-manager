class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :active
      t.integer :nexudus_user_id
      t.datetime :nexudus_updated_at
      t.datetime :nexudus_created_at
      t.uuid :nexudus_id

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :nexudus_updated_at
    add_index :users, :nexudus_id
  end
end
