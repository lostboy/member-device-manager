class Ability
  include CanCan::Ability

  def initialize(user)
    # Visitors must be signed to do anything at all
    return if user.nil?

    if user.manager?
      can :read, ActiveAdmin::Page, name: "Dashboard"
    end

    # Superadmins
    if user.superadmin?
      can :manage, :all
    end
  end
end
