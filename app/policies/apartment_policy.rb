class ApartmentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present? and (user.tenant? || user.owner? || user.admin?)
  end

  def create?
    user.owner?
  end

  def update?
    user.owner?
  end

  def destroy?
    user.owner?
  end

  def search?
    user.present? and (user.tenant? || user.admin?)
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.owner?
        scope.where(owner_id: user.id)
      elsif user.tenant?
        scope.all
      else
        scope.none
      end
    end
  end
end
