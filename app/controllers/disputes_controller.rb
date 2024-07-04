class DisputesController < ApplicationController
  before_action :authenticate_user!

  def index
    @booking = Booking.find(params[:booking_id])
    @disputes = Dispute.joins(:booking).where(booking_id: params[:booking_id])
  end

  def show
    @dispute = Dispute.find(params[:id])
    @booking = Booking.find(@dispute.booking_id)
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @dispute = Dispute.new(booking_id: @booking.id, user_id: current_user.id, status: 'pending')
  end

  def create
    @dispute = Dispute.new(dispute_params)
    @dispute.user_id = current_user.id
    @dispute.status = 'pending'

    authorize @dispute

    if @dispute.save
      redirect_to dispute_path(@dispute)
      flash[:notice] = 'Your request has been submitted.'
    else
      redirect_to new_dispute_path
      flash[:danger] = 'Unable to submit request.'
    end
  end

  private

  def dispute_params
    params.require(:dispute).permit(:description, :image, :booking_id )
  end
end
