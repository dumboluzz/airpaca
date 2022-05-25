class AlpacasController < ApplicationController
  WOOL_TYPES = ["Suri", "Huacaya"]
  COLORS = ["white", "gray", "brown", "black"]

  before_action :set_alpaca, only: [:show]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @alpacas = Alpaca.all
  end

  def show
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
    params.require(:alpaca).permit(:name, :nick_name, :age, :price_per_day,
                                   :height, :weight, :color, :wool_type, photos: [])
  end
end
