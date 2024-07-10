class DisputesController < ApplicationController
  before_action :authenticate_user!

  def index
    booking_id = params[:booking_id]

    if booking_id
      @disputes = Dispute.joins(:booking).where(booking_id: booking_id)
    else
      @disputes = Dispute.where(tenant_id: current_user.id) if current_user.tenant?
      @disputes = Dispute.where(owner_id: current_user.id) if current_user.owner?
    end
  end

  def show
    @dispute = Dispute.find(params[:id])

    @booking = Booking.find(@dispute.booking_id)
  end

  def new
    @booking = Booking.find(params[:booking_id])

    @dispute = Dispute.new
  end

  def create
    @dispute = Dispute.new(dispute_params)

    @booking = Booking.find(@dispute.booking_id)

    @dispute.owner = @booking.apartment.owner

    @dispute.tenant = @booking.tenant

    @dispute.status = 'pending'

    authorize @dispute

    if @dispute.save!
      redirect_to dispute_path(@dispute)
      flash[:notice] = t('website.dispute.sended')
    else
      redirect_to new_dispute_path
      flash[:danger] = t('website.dispute.not_send')
    end
  end

  private

  def dispute_params
    params.require(:dispute).permit(:description, :dispute_image, :booking_id)
  end
end
