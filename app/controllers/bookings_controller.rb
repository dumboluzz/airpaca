class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_alpaca, only: [:create]
  before_action :set_booking, only: [:accept, :reject]

  def index
    @pending = current_user.owner_bookings.where(status: "pending").order(:start_date)
    @history = current_user.owner_bookings.where.not(status: "pending").order(updated_at: :desc)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.alpaca = @alpaca
    @booking.renter = current_user
    duration = (@booking.end_date - @booking.start_date).to_i
    if duration.negative?
      flash.alert = "You can travel in time!"
      render "alpacas/show"
      return
    elsif duration.zero?
      @booking.full_price = @alpaca.price_per_day
    else
      @booking.full_price = duration * @alpaca.price_per_day
    end
    if @booking.save
      redirect_to alpaca_path(@alpaca), notice: "Booking successfull"
    else
      render "alpacas/show"
    end
  end

  def accept
    @booking.status = "accepted"
    @booking.save
    redirect_to bookings_path
  end

  def reject
    @booking.status = "rejected"
    @booking.save
    redirect_to bookings_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def set_alpaca
    @alpaca = Alpaca.find(params[:alpaca_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
