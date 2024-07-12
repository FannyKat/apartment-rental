class DisputePolicy < ApplicationPolicy

  def create?
    user.owner? || user.tenant?
  end

  def index?
    user.owner? || user.tenant?
  end
end
