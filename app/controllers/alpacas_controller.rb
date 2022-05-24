class AlpacasController < ApplicationController
  COLORS = ["white", "gray", "brown", "black"]
  WOOL_TYPES = ["Suri", "Huacaya"]

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @alpacas = Alpaca.all
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

  def alpaca_params
    params.require(:alpaca).permit(:name, :nick_name, :age, :price_per_day, :height, :weight, :color, :wool_type)
  end
end
