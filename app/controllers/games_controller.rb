class GamesController < ApplicationController
  def index
    @games = Games.all
  end

  def show
    @game = Game.find(params[:id])
  end
end
