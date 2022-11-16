# @format

class RentalsController < ApplicationController
  def index
    @rentals = policy_scope(Rental)
  end

  def create
    @rental = Rental.new(rental_params)
    authorize @rental
    @rental.offer = Offer.find(params[:offer_id])
    @rental.user = current_user
    if @rental.save
      redirect_to rentals_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :due_date)
  end
end
