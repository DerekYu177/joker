# frozen_string_literal: true

class Game < ApplicationRecord
  # a game is also analogous to a Room in chat parlence
  # it will also hold the associations to messages and cards

  has_many :teams
  has_many :players

  validates :name, presence: true, uniqueness: true # lol

  typed_store :settings do |s|
    s.integer :people_required, default: 6
    s.integer :initial_score_card_rank, default: 2
    s.integer :terminating_score_card_rank, default: 5
    s.boolean :loser_penalty, default: false
  end
end
