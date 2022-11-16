class RentalsController < ApplicationController
  def index
    @rentals = policy_scope(Rental)
  end
end
