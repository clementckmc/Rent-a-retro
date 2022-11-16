class Owner::RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def new
    raise
  end

  def create
    raise
  end
end
