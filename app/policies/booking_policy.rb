class BookingPolicy < ApplicationPolicy
  def create?
    user.tenant?
  end

  def approve?
    user.owner?
  end

  def reject?
    user.owner?
  end

  def booking?
    user.tenant?
  end

  def index?
    user.owner? || user.tenant?
  end

  def show?
    user.owner? || user.tenant?
  end
end
