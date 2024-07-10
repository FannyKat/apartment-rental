class DisputePolicy < ApplicationPolicy

  def create?
    user.owner? || user.tenant?
  end

end
