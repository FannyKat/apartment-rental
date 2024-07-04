class OwnershipRequestPolicy < ApplicationPolicy
  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(tenant: user)
      end
    end
  end
end
