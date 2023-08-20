# frozen_string_literal: true

class GameUser < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :team, required: false
end
