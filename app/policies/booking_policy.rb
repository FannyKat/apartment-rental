class BookingPolicy < ApplicationPolicy
  def create?
    user.tenant?
  end

  def booking?
    user.tenant?
  end

  def index?
    user.owner? || user.tenant?
  end

  def show?
    user.owner? || user.tenant? || user.admin?
  end

  def destroy?
    user.tenant?
  end

  def manage_booking?
    user.owner?
  end

  def accepted?
    user.owner?
  end

  def rejected?
    user.owner?
  end

  def pending?
    user.owner?
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
