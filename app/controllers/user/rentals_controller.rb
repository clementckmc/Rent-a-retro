class User::RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def new
    raise
  end

  def create
    raise
  end

  def update
    @rental = Rental.find(params[:id])
    redirect_to rentals_path
    # if @rental.update(rental_params)
    #   redirect_to rentals_path
    # else
    #   redirect_to rentals_path
    # end
  end
end
