# @format

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @games = Game.all.sample(4)
    @allgames = Game.all.count
    @allgameoffers = policy_scope(Game).where.associated(:offers).distinct.count
    @totaloffers = Offer.all.count
  end
end
