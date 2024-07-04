class RailsAdminPolicy < ApplicationPolicy

  def dashboard?
    user.admin?
  end
end
