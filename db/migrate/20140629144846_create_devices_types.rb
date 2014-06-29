class CreateDevicesTypes < ActiveRecord::Migration
  def change
    create_table :devices_types do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
