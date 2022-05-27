class PagesController < ApplicationController
  def home
    @alpacas = Alpaca.first(3)
  end
end
