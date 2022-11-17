# @format

class User::RentalsController < ApplicationController
  def index
    @rentals = policy_scope(Rental)
  end

  def new
    raise
  end

  def create
    raise
  end

  def update
    @rental = Rental.find(params[:id])
    authorize([:user, @rental])
    @rental.update(rental_params)
    redirect_to user_rentals_path
  end

  private

  def rental_params
    params.require(:rental).permit(:status)
  end
end
