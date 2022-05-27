class AlpacasController < ApplicationController
  before_action :set_alpaca, only: [:show, :edit, :update ]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:query].present?
      @alpacas = Alpaca.near(params[:query], params[:radius].present? ? params[:radius] : 50)
    else
      @alpacas = Alpaca.all
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
  end

  def create
    @alpaca = Alpaca.new(alpaca_params)
    @alpaca.owner = current_user
    if @alpaca.save
      redirect_to alpaca_path(@alpaca)
    else
      render :new
    end
  end

  def edit

  end

  def update
    @alpaca.update(alpaca_params)
    if @alpaca.save
      redirect_to alpaca_path(@alpaca)
    else
      render :edit
    end
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
