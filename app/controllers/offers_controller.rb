class OffersController < ApplicationController

  def show
    @offers = Offer.all
  end

  def new
    @user = current_user
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    if @offer.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.update(offer_params)
  end

  def destroy
    @offer = Offer.find(params[:id])
    if @offer.destroy
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:user_id, :game_id, :condition, :platform, :price)
  end
end
