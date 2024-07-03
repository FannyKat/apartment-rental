class ApartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_apartment, only: [:edit, :update, :destroy]

  after_action :verify_authorized, except: :index

  def index
    @apartments = Apartment.all
  end

  def show
    @apartments = current_user.apartments.all
    authorize @apartments
  end

  def search
    @apartments = Apartment.all
    authorize @apartments
    @apartments = @apartments.where("location ILIKE ?", "%#{params[:location]}%") if params[:location].present?
    @apartments = @apartments.where("rent_amount <= ?", params[:max_rent]) if params[:max_rent].present?
    @apartments = @apartments.where(number_of_bedrooms: params[:bedrooms]) if params[:bedrooms].present?
    render :index
  end

  def new
    @apartment = Apartment.new
    authorize @apartment
  end

  def update
    authorize @apartment

    if @apartment.update!(apartment_params)
      redirect_to @apartment, flash[:success] = 'Booking was successfully updated !'
    else
      render :edit, flash[:error] = "Booking not updated !"
    end
  end

  def edit
    authorize @apartment
  end

  def create
    @apartment = current_user.apartments.build(apartment_params)
    authorize @apartment

    if @apartment.save!
      redirect_to apartments_url
    else
      render :new
    end
  end

  def destroy
    authorize @apartment

    if @apartment.destroy
      flash[:success] = 'Apartment was successfully destroyed.'
      redirect_to apartments_path
    else
      redirect_to @apartment, flash[:error] = 'Failed to destroy apartment.'
    end
  end

  private

  def set_apartment
    @apartment = Apartment.find(params[:id])
  end

  def apartment_params
    params.require(:apartment).permit(:rent_amount, :number_of_bedrooms, :location, :amenities, :image)
  end
end
