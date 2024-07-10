class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def create?
    user.owner?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def admin_dashboard?
    user.admin?
  end

  def is_admin_or_owner?
    user.admin? || user.owner?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.owner?
        scope.where(owner_id: user.id)
      elsif user.tenant?
        scope.where(tenant_id: user.id)
      else
        scope.none
      end
    end
  end
end
