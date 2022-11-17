class User::OffersController < ApplicationController
  def index
    @offers = policy_scope(Offer)
  end

  def destroy
    @offer = Offer.find(params[:id])
    authorize([:user, @offer])
    @offer.destroy
    redirect_to user_offers_path, status: :see_other
  end
end
