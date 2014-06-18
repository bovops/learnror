class Ability
  include CanCan::Ability

  def initialize(user)

    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities

    if user
      user.admin? ? admin_abilities : user_abilities(user)
    else
      guest_abilities
    end

  end

  def user_abilities(user)
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :update, User, id: user.id
    can :destroy, User, id: user.id
    can :update, [Question, Answer, Comment], user_id: user.id
    can :destroy, [Question, Answer, Comment], user_id: user.id

    can :accept, Answer, question: {user_id: user.id}
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

end
