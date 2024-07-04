class DisputePolicy < ApplicationPolicy

  def create?
    user.owner?
  end

end
