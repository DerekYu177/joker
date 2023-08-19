# frozen_string_literal: true

class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    game = Game.new(**params[:game].permit(:name, :people_required, :loser_penalty))

    if game.save
      redirect_to game_path(game)
    else
      flash[:errors] = game.errors.full_messages
      redirect_to new_game_path
    end
  end

  def join
  end

  def show
  end
end
