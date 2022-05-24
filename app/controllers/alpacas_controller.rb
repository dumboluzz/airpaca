class AlpacasController < ApplicationController
  before_action :set_alpaca, only: [:show]

  def show
  end

  private

  def set_alpaca
    @alpaca = Alpaca.find(params[:id])
  end
end
