class ApartmentPolicy < ApplicationPolicy
  def show?
    user.tenant? || user.owner? || user.admin?
  end

  def create?
    user.owner? || user.admin?
  end

  def update?
    user.owner? || user.admin?
  end

  def destroy?
    user.owner? || user.admin?
  end

  def search?
    user.tenant? || user.owner?
  end

  def reserve?
    user.tenant?
  end

  def accept_reservation?
    user.owner?
  end

  def reject_reservation?
    user.owner?
  end
end
