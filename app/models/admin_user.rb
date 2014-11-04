class AdminUser < ActiveRecord::Base
  has_paper_trail

  include RoleModel

  devise :database_authenticatable, :rememberable, :recoverable, :trackable

  roles :superadmin, :manager

  validates :first_name, presence: true

  def name
    if last_name
      "#{first_name} #{last_name}"
    else
      first_name
    end
  end
end
