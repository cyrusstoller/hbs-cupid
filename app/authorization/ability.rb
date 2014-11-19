class Ability
  include CanCan::Ability

  def initialize(user)
  # Define abilities for the passed in user here. For example:
  #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    end

    can :create, SubmittedAnswer
    can :update, SubmittedAnswer, :user_id => user.id

    if user.active?
      can :manage, Question
    end
  end
end