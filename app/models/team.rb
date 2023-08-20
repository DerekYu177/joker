# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :game_users
  belongs_to :game, required: true

  alias_method :players, :game_users
end
