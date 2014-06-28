class Ability
  include CanCan::Ability

  def initialize(user)

    # Any admin user
    if user.present?
      can :read, ActiveAdmin::Page, name: "Dashboard"
    end

    # Superadmins
    can :manage, :all if user.superadmin?

    # Editors
    #can :manage, Article if user.editor?
  end
end
