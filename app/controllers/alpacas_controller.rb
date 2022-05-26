class AlpacasController < ApplicationController
  before_action :set_alpaca, only: [:show]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:query].present?
      @alpacas = Alpaca.search_by_city(params[:query])
    else
      @alpacas = Alpaca.all
    end
    @markers = @alpacas.geocoded.map do |alpaca|
      {
        lat: alpaca.latitude,
        lng: alpaca.longitude
      }
    end
  end

  def show
    @booking = Booking.new
    @markers = [{ lat: @alpaca.latitude, lng: @alpaca.longitude }]
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

  private

  def set_alpaca
    @alpaca = Alpaca.find(params[:id])
  end

  def alpaca_params
    params.require(:alpaca).permit(:name, :nick_name, :age, :price_per_day, :address,
                                   :height, :weight, :color, :wool_type, photos: [])
  end
end
