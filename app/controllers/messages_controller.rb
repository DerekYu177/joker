# # frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :api_only
  before_action :find_game

  def create
    create_params = params.permit(:body, :player_id)

    Message.create!(game: @game, **create_params) 

    render(:ok)
  end

  private

  def api_only
    render(:bad_request) unless request.format.json?
  end

  def find_game
    @game = Game.find_by(**params.permit(:id))

    render(:not_found) if @game.blank?
  end
end
