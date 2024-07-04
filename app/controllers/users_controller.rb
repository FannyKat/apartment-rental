class UsersController < ApplicationController
  before_action :authenticate_user!

  def switch_role
    if current_user.owner?
      current_user.update(role: "tenant")

      redirect_to root_path

      flash[:notice] = "Switched to Tenant role. You can now view all apartments."
    else
      current_user.update(role: "owner")

      redirect_to root_path

      flash[:notice] = "Switched to Owner role. You can now view your apartments."
    end
  end
end
