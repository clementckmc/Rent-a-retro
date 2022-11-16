class PagesController < ApplicationController
  def home
    @games = Game.all
  end
end
