class OwnershipRequestsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_ownership

  def new
  end

  def create
    @ownership_request = OwnershipRequest.new(ownership_request_params)

    if @ownership_request.save
      redirect_to edit_user_registration_path
      flash[:notice] = 'Your request has been submitted.'
    else
      redirect_to new_ownership_request_path
      flash[:danger] = 'Unable to submit request.'
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
