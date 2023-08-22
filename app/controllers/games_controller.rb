# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :find_game, only: %i(join show)

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    game = Game.new(**params[:game].permit(:name, :people_required, :loser_penalty))
    user = User.new(name: params[:game].permit(:player)[:player])

    records = ApplicationRecord.transaction do
      game.save!
      user.save!
    end

    if records
      Player.create(user: user, game: game)
      # set the player in the session
      redirect_to game_path(game)
    else
      flash[:errors] = game.errors.full_messages + user.errors.full_messages
      redirect_to new_game_path
    end
  end

  def join
    user = User.new(**params.permit(:name))
    if user.save
      Player.create(user: user, game: @game)
      # set the player in the session
      redirect_to game_path(@game)
    else
      flash[:join_error] = user.errors.first.full_message 
      redirect_to games_path
    end
  end

  def show
  end

  private

  def find_game
    @game = Game.find_by(**params.permit(:id))

    redirect_to :index if @game.blank?
  end
end
