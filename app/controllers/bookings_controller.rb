class BookingsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_booking, only: [:show, :edit, :update, :destroy, :rejected, :accepted, :pending, :canceled]

  before_action :set_apartment, only: [:create, :new]

  after_action :verify_authorized

  # List bookings through tenant or owner

  def index
    if current_user.tenant?
      @bookings = current_user.bookings.all

    elsif current_user.owner?
      @bookings = Booking.joins(:apartment).where(apartments: { owner_id: current_user.id })
    elsif current_user.admin?
      @bookings = Booking.all
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
      flash[:success] = t('website.message.success')

      redirect_to bookings_path
    else
      flash[:danger] = @booking.errors.full_messages.to_sentence

      redirect_to new_booking_path
    end
  end

  def update
    if @booking.update(booking_params)
      flash[:success] = t('website.message.updated')

      redirect_to @booking
    else
      flash[:danger] = @booking.errors.full_messages.to_sentence

      rendirect_to edit_booking_path
    end

    authorize @booking
  end

  def destroy
    authorize @booking

    if @booking.destroy
      flash[:danger] = t('website.message.booking.destroyed')

      redirect_to bookings_url
    else
      flash[:danger] = @apartments.errors.full_messages.to_sentence

      redirect_to @apartment
    end
  end

  # Methods to owner's manage booking

  def accepted
    if booking_exists_for_same_date?
      authorize @booking

      flash[:error] = t('website.booking.error.same_date')

      redirect_to bookings_path

      return
    end

    @booking.accepted!

    authorize @booking

    flash[:success] = t('website.booking.accepted')

    redirect_to bookings_url
  end

  def rejected
    @booking.rejected!

    authorize @booking

    flash[:danger] = t('website.booking.rejected')

    redirect_to bookings_url
  end

  def pending
    @booking.pending!

    authorize @booking

    flash[:warning] = t('website.booking.pending')

    redirect_to bookings_url
  end

  def canceled
    @booking.canceled!

    authorize @booking

    flash[:warning] = t('website.booking.canceled')

    redirect_to bookings_url
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
