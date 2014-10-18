ActiveAdmin.register Devices::Device, as: 'Device' do

  member_action :renew do
    resource.renew!
    redirect_to :back, notice: I18n.t("admin.renewed", resource: resource.class.model_name.human)
  end

  member_action :release do
    resource.release!
    redirect_to :back, notice: I18n.t("admin.released", resource: resource.class.model_name.human)
  end

  index do
    selectable_column
    id_column

    column :mac_address
    column :ip_address
    column :updated_at
    column :created_at
    actions defaults: true do |device|
      links = []

      links << link_to(I18n.t("admin.renew"), renew_admin_device_path(device.id))
      links << link_to(I18n.t("admin.release"), release_admin_device_path(device.id))

      links.join(" ").html_safe
    end
  end

  action_item only: :show do
    link_to(I18n.t("admin.renew"), renew_admin_device_path(resource.id))
  end

  action_item only: :show do
    link_to(I18n.t("admin.release"), release_admin_device_path(resource.id))
  end
end
