class OwnershipRequestsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_ownership

  def new
  end

  def create
    @ownership_request = OwnershipRequest.new(ownership_request_params)

    if @ownership_request.save
      flash[:notice] = t('website.message.success')

      redirect_to edit_user_registration_path
    else
      flash[:danger] = @ownership_request.errors.full_messages.to_sentence

      redirect_to new_ownership_request_path
    end
  end

  private

  def set_ownership
    @ownership_request = OwnershipRequest.new(
      tenant: current_user,
      status: 'pending',
      email: current_user.email
    )
  end

  def ownership_request_params
    params.require(:ownership_request).permit(:email, :first_name, :last_name, :tenant_id, :cin)
  end
end
