# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: true # lol

  typed_store :settings do |s|
    s.integer :people_required, null: false
    s.boolean :loser_penalty
  end
end
