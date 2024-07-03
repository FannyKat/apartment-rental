class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :approve, :reject]
  before_action :set_apartment, only: [:create, :new]
  after_action :verify_authorized

  def index
    @bookings = Booking.all
    authorize @bookings
  end

  def show
    @bookings = Booking.all
    authorize @bookings
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
    @booking.user = current_user

    authorize @booking

    if @booking.save!
      redirect_to @booking, notice: 'Booking was succesfully created !'
    else
      render :new
    end
  end

  def update
    authorize @booking

    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Booking was successfully updated !'
    else
      render :edit
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to bookings_url, notice: 'Booking was successfully destroyed !'
  end

  def approve
    authorize @booking
    @booking.update(status: 'approved')
    redirect_to @booking.apartment, notice: 'Booking approved.'
  end

  def reject
    authorize @booking
    @booking.update(status: 'rejected')
    redirect_to @booking.apartment, notice: 'Booking rejected.'
  end

  private

  def set_apartment
    @apartment = Apartment.find(params[:booking][:apartment_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date, :apartment_id)
  end
end
