# @format

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @games = Game.all.sample(4)
    @games_count = Game.all.count
    @game_offers_count = policy_scope(Game).where.associated(:offers).distinct.count
    @offers_count = Offer.all.count
  end
end
