class User::OffersController < ApplicationController
  def index
    @offers = policy_scope([:user, Offer])
  end
end
