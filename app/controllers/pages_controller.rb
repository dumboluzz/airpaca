class PagesController < ApplicationController
  def home
    @alpacas = Alpaca.first(3)

    @alpacas_map = Alpaca.all
    @markers = @alpacas_map.geocoded.map do |alpaca|
      {
        href: alpaca_path(alpaca),
        img: alpaca.photos.attached? ? helpers.cl_image_path(alpaca.photos.first.key, width: 150, height: 150, crop: :fill) : "https://i.imgflip.com/6hf6ez.jpg",
        lat: alpaca.latitude,
        lng: alpaca.longitude
      }
    end
  end
end
