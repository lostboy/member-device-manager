class AdminUser < ActiveRecord::Base
  has_paper_trail

  include RoleModel

  devise :database_authenticatable, :rememberable, :recoverable, :trackable

  roles :superadmin, :manager
end
