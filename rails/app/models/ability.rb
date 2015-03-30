class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    #Define a couple of abilities
    if user.is? :admin
        can :manage, :all
    else 
        can :show, User, :id => user.id
        can :edit, User, :id => user.id
        can :update, User, :id => user.id
        can :destroy, User, :id => user.id
    end
  end
end
