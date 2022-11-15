class Owner::RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end
end
