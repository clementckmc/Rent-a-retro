# @format

class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @games = policy_scope(Game)
  end

  def show
    @game = Game.find(params[:id])
  end
end
