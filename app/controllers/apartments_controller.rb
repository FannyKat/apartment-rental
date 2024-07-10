class ApartmentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_apartment, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized

  def index
    @apartments = policy(:user).owner? ? current_user.apartments : Apartment.all

    authorize @apartments
  end

  def show
    @apartment

    authorize @apartment
  end

  def search
    @apartments = Apartment.all

    authorize @apartments

    @apartments = @apartments.where("location ILIKE ?", "%#{params[:location]}%") if params[:location].present?
    @apartments = @apartments.where("rent_amount >= ?", params[:min_rent]) if params[:min_rent].present?
    @apartments = @apartments.where("rent_amount <= ?", params[:max_rent]) if params[:max_rent].present?
    @apartments = @apartments.where(number_of_bedrooms: params[:bedrooms]) if params[:bedrooms].present?

    render :index
  end

  def new
    @apartment = Apartment.new
    authorize @apartment
  end

  def edit
    authorize @apartment
  end

  def update
    authorize @apartment

    if @apartment.update(apartment_params)
      @apartments = current_user.apartments
      redirect_to apartments_path
      flash[:success] = 'Apartment was successfully updated !'
    else
      redirect_to edit_apartment_path
      flash[:danger] = "Apartment not updated !"
    end
  end

  def create
    @apartment = Apartment.create(apartment_params)
    @apartment.owner = current_user

    authorize @apartment

    if @apartment.save
      redirect_to apartments_path
      flash[:success] = "Apartment was successfully created !"
    else
      redirect_to new_apartment_path
      flash[:danger] = "Apartment was not created."
    end
  end

  def destroy
    authorize @apartment

    if @apartment.destroy
      flash[:success] = 'Apartment was successfully destroyed.'
      redirect_to apartments_path
    else
      redirect_to @apartment
      flash[:danger] = 'Failed to destroy apartment.'
    end
  end

  private

  def set_apartment
    @apartment = Apartment.find(params[:id])
  end

  def apartment_params
    params.require(:apartment).permit(
      :rent_amount, :number_of_bedrooms, :location,
      :amenities, :image, :title, images: []
    )
  end
end
