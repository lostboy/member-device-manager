class AdminUser < ActiveRecord::Base
  include RoleModel

  devise :database_authenticatable, :rememberable, :recoverable, :trackable

  roles :superadmin, :manager
end
