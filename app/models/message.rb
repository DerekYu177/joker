# # frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :game
  belongs_to :player
  
  validates :game, :player, :body, presence: true

  after_create_commit do
    broadcast_append_to(
      "messages", 
      partial: "messages/message",
      locals: { message: self },
      target: "messages",
    )
  end  
end

