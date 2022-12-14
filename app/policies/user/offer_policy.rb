class User::OfferPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end
  def index?
    true
  end
  def create?
    true
  end
  def destroy?
    true
  end
end
