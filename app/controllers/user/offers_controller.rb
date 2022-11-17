class User::OffersController < ApplicationController
  def index
    @games = policy_scope(Game).where.associated(:offers)
  end
end
