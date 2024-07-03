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

  def search?
    user.owner? || user.tenant?
  end

  def permitted_attributes
    if user.id == record.id
      [:email, :password, :password_confirmation, :current_password, :role]
    else
      [:email, :password, :password_confirmation, :current_password]
    end
  end
end
