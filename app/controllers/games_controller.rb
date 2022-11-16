# @format

class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @games = policy_scope(Game).where.associated(:offers)
  end

  def show
    @game = policy_scope(Game).find(params[:id])
    authorize @game
    @rental = Rental.new
    authorize @rental
  end
end
