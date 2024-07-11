class UsersController < ApplicationController
  before_action :authenticate_user!

  def switch_role
    if current_user.owner?
      current_user.update(role: "tenant")

      flash[:notice] = t('website.role.switch_to_tenant')

      redirect_to root_path
    else
      current_user.update(role: "owner")

      flash[:notice] = t('website.role.switch_to_owner')

      redirect_to root_path
    end
  end
end
