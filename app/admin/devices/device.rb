ActiveAdmin.register Devices::Device, as: 'Device' do

  index do
    selectable_column
    id_column
    column :mac_address
    column :updated_at
    column :created_at
    actions
  end

end
