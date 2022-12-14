# @format

class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    if params[:query].present?
    @games = policy_scope(Game).select("DISTINCT ON (games.id) games.*").where.associated(:offers).search(params[:query]).reorder(:id)
    else
    @games = policy_scope(Game).where.associated(:offers).distinct
    end
  end

  def show
    @game = policy_scope(Game).find(params[:id])
    authorize @game
    @rental = Rental.new
    authorize @rental
  end
end
