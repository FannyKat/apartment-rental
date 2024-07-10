class BookingsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_booking, only: [:show, :edit, :update, :destroy, :rejected, :accepted, :pending, :canceled]

  before_action :set_apartment, only: [:create, :new]

  after_action :verify_authorized

  def index
    if current_user.tenant?
      @bookings = current_user.bookings.all
    elsif current_user.owner?
      @bookings = Booking.joins(:apartment).where(apartments: { owner_id: current_user.id })
    end

    authorize @bookings
  end

  def show
    @booking

    authorize @booking
  end

  def new
    @booking = @apartment.bookings.build

    authorize @booking
  end

  def edit
  end

  def create
    @booking = Booking.new(booking_params)

    @booking.apartment = @apartment

    @booking.tenant = current_user

    @booking.status = "pending"

    authorize @booking

    if @booking.save
      redirect_to bookings_path
      flash[:success] = 'Booking was succesfully created !'
    else
      redirect_to new_booking_path
      flash[:danger] = 'An error occured. Booking was not created.'
    end
  end

  def update
    if @booking.update(booking_params)
      flash[:success] = 'Booking was successfully updated !'
      redirect_to @booking
    else
      rendirect_to edit_booking_path
      flash[:danger] = 'An error occured. Booking was not updated.'
    end

    authorize @booking
  end

  def destroy
    @booking.destroy

    authorize @booking

    redirect_to bookings_url

    flash[:danger] = 'Booking was successfully destroyed !'
  end

  # Methods to owner's manage booking

  def accepted
    if booking_exists_for_same_date?
      authorize @booking

      redirect_to bookings_path
      flash[:error] = "Cannot accept booking. Another booking exists for same date."

      return
    end

    @booking.accepted!

    authorize @booking

    redirect_to bookings_url
    flash[:success] = t('website.booking.accepted')
  end

  def rejected
    @booking.rejected!

    authorize @booking

    redirect_to bookings_url

    flash[:danger] = t('website.booking.rejected')
  end

  def pending
    @booking.pending!

    authorize @booking

    redirect_to bookings_url

    flash[:warning] = t('website.booking.pending')
  end

  def canceled
    @booking.canceled!

    authorize @booking

    redirect_to bookings_url

    flash[:warning] = t('website.booking.canceled')
  end

  private

  def booking_exists_for_same_date?
    existing_booking = Booking.where(status: "accepted", apartment_id: @booking.apartment_id)
                              .where("start_date <= ? AND end_date >= ?", @booking.end_date, @booking.start_date)
                              .where.not(id: @booking.id)

    existing_booking.exists?
  end

  def set_apartment
    if params[:booking]
      @apartment = Apartment.find(params[:booking][:apartment_id])
    else
      @apartment = Apartment.find(params[:apartment_id])
    end
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date, :apartment_id, :message)
  end
end
