class AlpacasController < ApplicationController
  before_action :set_alpaca, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @alpacas = policy_scope(Alpaca).near(params[:query], params[:radius].present? ? params[:radius] : 50)
    else
      @alpacas = policy_scope(Alpaca).all
    end
    @markers = @alpacas.geocoded.map do |alpaca|
      {
        href: alpaca_path(alpaca),
        img: alpaca.photos.attached? ? helpers.cl_image_path(alpaca.photos.first.key, width: 150, height: 150, crop: :fill) : "https://i.imgflip.com/6hf6ez.jpg",
        lat: alpaca.latitude,
        lng: alpaca.longitude
      }
    end
  end

  def show
    authorize @alpaca
    @booking = Booking.new
    @markers = [{
      href: "#",
      img: @alpaca.photos.attached? ? helpers.cl_image_path(@alpaca.photos.first.key, width: 150, height: 150, crop: :fill) : "https://i.imgflip.com/6hf6ez.jpg",
      lat: @alpaca.latitude,
      lng: @alpaca.longitude
    }]
  end

  def new
    @alpaca = Alpaca.new
    authorize @alpaca
  end

  def create
    @alpaca = Alpaca.new(alpaca_params)
    authorize @alpaca
    @alpaca.owner = current_user
    if @alpaca.save
      redirect_to alpaca_path(@alpaca)
    else
      render :new
    end
  end

  def edit
    authorize @alpaca
  end

  def update
    authorize @alpaca
    @alpaca.update(alpaca_params)
    if @alpaca.save
      redirect_to alpaca_path(@alpaca)
    else
      render :edit
    end
  end

  def destroy
    authorize @alpaca
    @alpaca.destroy
    redirect_to alpacas_path
  end

  private

  def set_alpaca
    @alpaca = Alpaca.find(params[:id])
  end

  def alpaca_params
    params.require(:alpaca).permit(:name, :nick_name, :age, :description, :price_per_day, :address,
                                   :height, :weight, :color, :wool_type, photos: [])
  end
end
